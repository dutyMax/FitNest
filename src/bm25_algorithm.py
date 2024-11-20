# src/bm25_algorithm.py
import math
import re
from data_parser import parse_workout_data, clean_workout_data, total_avg_doc_len

def clean_query(query):
    return [word.lower() for word in re.findall(r'\b\w+\b', query)]

def BM25(query, tfs, dfs, doc_lengths, avg_lengths):
    k1 = 1.3
    btitle = 0.75
    bbody = 0.25
    bbody_part = 0.7  # Adjusted normalization factor for BodyPart
    bequipment = 0.5

    title_weight = 3
    body_weight = 0.1
    body_part_weight = 4  # Increased weight for BodyPart
    equipment_weight = 1.5

    bm25_scores = {}

    for doc_id in tfs:
        score = 0
        for word in query:
            # Title BM25
            if word in tfs[doc_id]['title']:
                tf_title = tfs[doc_id]['title'][word]
                title_len = doc_lengths[doc_id]['title']
                title_score = (tf_title * (k1 + 1)) / (tf_title + k1 * (1 - btitle + btitle * title_len / avg_lengths['title']))
                idf_title = math.log((len(tfs) - len(dfs.get(word, [])) + 0.5) / (len(dfs.get(word, [])) + 0.5) + 1)
                score += title_weight * title_score * idf_title

            # Body BM25
            if word in tfs[doc_id]['body']:
                tf_body = tfs[doc_id]['body'][word]
                body_len = doc_lengths[doc_id]['body']
                body_score = (tf_body * (k1 + 1)) / (tf_body + k1 * (1 - bbody + bbody * body_len / avg_lengths['body']))
                idf_body = math.log((len(tfs) - len(dfs.get(word, [])) + 0.5) / (len(dfs.get(word, [])) + 0.5) + 1)
                score += body_weight * body_score * idf_body

            # BodyPart BM25 (increased weight)
            if word in tfs[doc_id]['body_part']:
                tf_body_part = tfs[doc_id]['body_part'][word]
                body_part_len = doc_lengths[doc_id]['body_part']
                body_part_score = (tf_body_part * (k1 + 1)) / (tf_body_part + k1 * (1 - bbody_part + bbody_part * body_part_len / avg_lengths['body_part']))
                idf_body_part = math.log((len(tfs) - len(dfs.get(word, [])) + 0.5) / (len(dfs.get(word, [])) + 0.5) + 1)
                score += body_part_weight * body_part_score * idf_body_part

            # Equipment BM25
            if word in tfs[doc_id]['equipment']:
                tf_equipment = tfs[doc_id]['equipment'][word]
                equipment_len = doc_lengths[doc_id]['equipment']
                equipment_score = (tf_equipment * (k1 + 1)) / (tf_equipment + k1 * (1 - bequipment + bequipment * equipment_len / avg_lengths['equipment']))
                idf_equipment = math.log((len(tfs) - len(dfs.get(word, [])) + 0.5) / (len(dfs.get(word, [])) + 0.5) + 1)
                score += equipment_weight * equipment_score * idf_equipment

        bm25_scores[doc_id] = score

    return sorted(bm25_scores.items(), key=lambda x: x[1], reverse=True)

# def BM25(query, tfs, dfs, doc_lengths, avg_lengths):
#     k1 = 1.3
#     btitle = 0.75
#     bbody = 0.25
#     bbody_part = 0.5
#     bequipment = 0.5
#     title_weight = 3
#     body_weight = 0.1
#     body_part_weight = 2
#     equipment_weight = 1.5
#     bm25_scores = {}

#     for doc_id in tfs:
#         score = 0
#         for word in query:
#             # Title BM25
#             if word in tfs[doc_id]['title']:
#                 tf_title = tfs[doc_id]['title'][word]
#                 title_len = doc_lengths[doc_id]['title']
#                 title_score = (tf_title * (k1 + 1)) / (tf_title + k1 * (1 - btitle + btitle * title_len / avg_lengths['title']))
#                 idf_title = math.log((len(tfs) - len(dfs.get(word, [])) + 0.5) / (len(dfs.get(word, [])) + 0.5) + 1)
#                 score += title_weight * title_score * idf_title

#             # Body BM25
#             if word in tfs[doc_id]['body']:
#                 tf_body = tfs[doc_id]['body'][word]
#                 body_len = doc_lengths[doc_id]['body']
#                 body_score = (tf_body * (k1 + 1)) / (tf_body + k1 * (1 - bbody + bbody * body_len / avg_lengths['body']))
#                 idf_body = math.log((len(tfs) - len(dfs.get(word, [])) + 0.5) / (len(dfs.get(word, [])) + 0.5) + 1)
#                 score += body_weight * body_score * idf_body

#             # BodyPart BM25
#             if word in tfs[doc_id]['body_part']:
#                 tf_body_part = tfs[doc_id]['body_part'][word]
#                 body_part_len = doc_lengths[doc_id]['body_part']
#                 body_part_score = (tf_body_part * (k1 + 1)) / (tf_body_part + k1 * (1 - bbody_part + bbody_part * body_part_len / avg_lengths['body_part']))
#                 idf_body_part = math.log((len(tfs) - len(dfs.get(word, [])) + 0.5) / (len(dfs.get(word, [])) + 0.5) + 1)
#                 score += body_part_weight * body_part_score * idf_body_part

#             # Equipment BM25
#             if word in tfs[doc_id]['equipment']:
#                 tf_equipment = tfs[doc_id]['equipment'][word]
#                 equipment_len = doc_lengths[doc_id]['equipment']
#                 equipment_score = (tf_equipment * (k1 + 1)) / (tf_equipment + k1 * (1 - bequipment + bequipment * equipment_len / avg_lengths['equipment']))
#                 idf_equipment = math.log((len(tfs) - len(dfs.get(word, [])) + 0.5) / (len(dfs.get(word, [])) + 0.5) + 1)
#                 score += equipment_weight * equipment_score * idf_equipment

#         bm25_scores[doc_id] = score

#     return sorted(bm25_scores.items(), key=lambda x: x[1], reverse=True)



# def BM25(query, tfs, dfs, doc_lengths, avg_lengths):
#     k1 = 1.3
#     btitle = 0.75
#     bbody = 0.25
#     title_weight = 3
#     body_weight = 0.1
#     bm25_scores = {}

#     for doc_id in tfs:
#         score = 0
#         for word in query:
#             # Title BM25
#             if word in tfs[doc_id]['title']:
#                 tf_title = tfs[doc_id]['title'][word]
#                 title_len = doc_lengths[doc_id]['title']
#                 title_score = (tf_title * (k1 + 1)) / (tf_title + k1 * (1 - btitle + btitle * title_len / avg_lengths['title']))
#                 idf_title = math.log((len(tfs) - len(dfs.get(word, [])) + 0.5) / (len(dfs.get(word, [])) + 0.5) + 1)
#                 score += title_weight * title_score * idf_title

#             # Body BM25
#             if word in tfs[doc_id]['body']:
#                 tf_body = tfs[doc_id]['body'][word]
#                 body_len = doc_lengths[doc_id]['body']
#                 body_score = (tf_body * (k1 + 1)) / (tf_body + k1 * (1 - bbody + bbody * body_len / avg_lengths['body']))
#                 idf_body = math.log((len(tfs) - len(dfs.get(word, [])) + 0.5) / (len(dfs.get(word, [])) + 0.5) + 1)
#                 score += body_weight * body_score * idf_body

#         bm25_scores[doc_id] = score

#     return sorted(bm25_scores.items(), key=lambda x: x[1], reverse=True)
