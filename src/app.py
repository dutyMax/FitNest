# from flask import Flask, request, jsonify
# from bm25_algorithm import BM25, clean_query
# from data_parser import parse_workout_data, clean_workout_data, total_avg_doc_len

# # Initialize the Flask app
# app = Flask(__name__)

# # Path to your workout data CSV file
# WORKOUT_DATA_FILE = "../data/workout_data.csv"

# # Parse and clean the workout data once at startup
# workout_data = parse_workout_data(WORKOUT_DATA_FILE)
# tfs, dfs, doc_lengths = clean_workout_data(workout_data)
# avg_lengths = total_avg_doc_len(doc_lengths)

# # Define a route to get workout recommendations
# @app.route("/recommendations", methods=["POST"])
# def get_recommendations():
#     # Get the query from the POST request
#     query_data = request.get_json()
#     query = query_data.get("query", "")
    
#     # Clean the query
#     query = clean_query(query)
    
#     # Get ranked workouts using BM25
#     ranked_workouts = BM25(query, tfs, dfs, doc_lengths, avg_lengths)
    
#     # Extract the top 5 results
#     top_workouts = [
#         {
#             "Title": workout_data[doc_id]['Title'],
#             "Score": score
#         }
#         for doc_id, score in ranked_workouts[:5]
#     ]
    
#     # Return the recommendations as JSON
#     return jsonify({"recommendations": top_workouts})

# if __name__ == "__main__":
#     app.run(host="0.0.0.0", port=5001, debug=True)


from flask import Flask, request, jsonify
from bm25_algorithm import BM25, clean_query
from data_parser import parse_workout_data, clean_workout_data, total_avg_doc_len

# Initialize the Flask app
app = Flask(__name__)

# Path to your workout data CSV file
# WORKOUT_DATA_FILE = "./workout_data.csv"
WORKOUT_DATA_FILE = "../data/workout_data.csv"

# Parse and clean the workout data once at startup
workout_data = parse_workout_data(WORKOUT_DATA_FILE)
tfs, dfs, doc_lengths = clean_workout_data(workout_data)
avg_lengths = total_avg_doc_len(doc_lengths)

# Define a route to get workout recommendations
@app.route("/recommendations", methods=["POST"])
def get_recommendations():
    # Get the query from the POST request
    query_data = request.get_json()
    query = query_data.get("query", "")
    
    # Clean the query
    query = clean_query(query)
    
    # Get ranked workouts using BM25
    ranked_workouts = BM25(query, tfs, dfs, doc_lengths, avg_lengths)
    
    # Extract the top 5 results with additional fields
    top_workouts = [
        {
            "Title": workout_data[doc_id]['Title'],
            "Desc": workout_data[doc_id]['Desc'],
            "BodyPart": workout_data[doc_id]['BodyPart'],
            "Equipment": workout_data[doc_id]['Equipment'],
            "Level": workout_data[doc_id]['Level'],
            "Score": score
        }
        for doc_id, score in ranked_workouts[:5]
    ]
    
    # Return the recommendations as JSON
    return jsonify({"recommendations": top_workouts})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5001, debug=True)
