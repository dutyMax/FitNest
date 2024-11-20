# src/main.py
import os
import json
from bm25_algorithm import BM25, clean_query
from data_parser import parse_workout_data, clean_workout_data, total_avg_doc_len

def get_workout_recommendations(query):
    # File path to the CSV data
    file_path = os.path.join("../data", "workout_data.csv")

    # Parse and clean workout data
    workout_data = parse_workout_data(file_path)
    tfs, dfs, doc_lengths = clean_workout_data(workout_data)
    avg_lengths = total_avg_doc_len(doc_lengths)

    # Clean the query
    query = clean_query(query)
    
    # Get ranked workouts using BM25
    ranked_workouts = BM25(query, tfs, dfs, doc_lengths, avg_lengths)

    # Return the top 5 workouts
    top_workouts = [
        {
            "Title": workout_data[doc_id]['Title'],
            "Score": score
        }
        for doc_id, score in ranked_workouts[:5]
    ]
    return top_workouts

if __name__ == "__main__":
    query = "abdominals intermediate bands"
    recommendations = get_workout_recommendations(query)
    print(json.dumps(recommendations, indent=2))
