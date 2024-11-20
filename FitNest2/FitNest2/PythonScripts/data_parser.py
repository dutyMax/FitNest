# src/data_parser.py
import csv
import os
import re

def parse_workout_data(file_path):
    workout_data = []

    # Open the CSV file and parse its contents
    with open(file_path, mode='r') as file:
        reader = csv.DictReader(file)
        for row in reader:
            workout_data.append({
                "Title": row["Title"],
                "Desc": row["Desc"],
                "Type": row["Type"],
                "BodyPart": row["BodyPart"],
                "Equipment": row["Equipment"],
                "Level": row["Level"]
            })
    
    return workout_data

def clean_workout_data(workout_data):
    doc_lengths = {}
    tfs = {}
    dfs = {}
    
    for index, exercise in enumerate(workout_data):
        title_words = exercise['Title'].lower().split()
        desc_words = re.findall(r'\b\w+\b', exercise['Desc'].lower())
        
        # Calculate term frequencies
        title_tf = {word: title_words.count(word) for word in set(title_words)}
        desc_tf = {word: desc_words.count(word) for word in set(desc_words)}
        
        # Populate term frequencies
        tfs[index] = {"title": title_tf, "body": desc_tf}
        
        # Document lengths
        doc_lengths[index] = {"title": len(title_words), "body": len(desc_words)}
        
        # Document frequency calculation
        for word in set(title_words + desc_words):
            if word in dfs:
                dfs[word].append(index)
            else:
                dfs[word] = [index]

    return tfs, dfs, doc_lengths

def total_avg_doc_len(doc_lengths):
    avg_title_len = sum(d['title'] for d in doc_lengths.values()) / len(doc_lengths)
    avg_body_len = sum(d['body'] for d in doc_lengths.values()) / len(doc_lengths)
    return {"title": avg_title_len, "body": avg_body_len}
