# src/main.py
import os
from bm25_algorithm import BM25, clean_query
from data_parser import parse_workout_data, clean_workout_data, total_avg_doc_len

def main():
    # File path to the CSV data
    file_path = os.path.join("../data", "workout_data.csv")

    # Parse and clean workout data
    workout_data = parse_workout_data(file_path)
    tfs, dfs, doc_lengths = clean_workout_data(workout_data)
    avg_lengths = total_avg_doc_len(doc_lengths)

    # Prompt the user for a query
    user_query = input("Enter your fitness needs (e.g., 'abdominals intermediate bands'): ")
    query = clean_query(user_query)
    
    # Get ranked workouts using BM25
    ranked_workouts = BM25(query, tfs, dfs, doc_lengths, avg_lengths)

    # Print top ranked workouts
    print("\nTop Workouts for Your Query:")
    for doc_id, score in ranked_workouts[:5]:
        workout = workout_data[doc_id]
        print(f"Title: {workout['Title']}, Score: {score}")

if __name__ == "__main__":
    main()
