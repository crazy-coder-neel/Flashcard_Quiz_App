import google.generativeai as genai
from flask import Flask,jsonify,request,json
from flask_cors import CORS
import re
import os
from dotenv import load_dotenv
load_dotenv()

app=Flask(__name__)
CORS(app)

genai.configure(api_key=os.getenv("GEMINI_API_KEY")) 
model = genai.GenerativeModel("gemini-2.0-flash")
chat = model.start_chat(history=[])

@app.route("/api",methods=["GET"])
def chatResponse():
    user_input=str(request.args["query"])
    if user_input.lower() == 'exit':
        return jsonify({"output":"Conversation ended"})
    
    try:
        chatbot_reply = chat.send_message(user_input)
        return jsonify({"output":re.sub(r'[\*#`]', '',chatbot_reply.text )})
    except Exception as e:
        return jsonify({"output":e})


@app.route("/quiz",methods=["GET"])
def dynamicQuiz():
    topic=str(request.args["topic"])
    number=str(request.args["no"])
    level=str(request.args["cat"])
    prompt = (
        f"You have to generate {number} MCQs on the following topic: {topic} the level of questions should be{level}"
        "Note that the questions should be unique; no duplicate or repeated questions should be there. "
        "Also generate an explanation about the answers clearly and concisely."
        "Example format: Q1.Your question , then leave a line and give 4 options each on separate line with alphabets a,b,c &d for each next leave another line and provide the correct answer with option and provide its explanation as well , further leave 2 lines and then begin with next question. "
        "I dont want any other responses like my expected results , neither okay nor thankyou etc none , just start with MCQ's directly."
        "Strictly I dont want any special character as \,*,#,` etc in the response & no additional text just what i have asked for and no unnecessary characters."
    )
    try:
        response = model.generate_content(prompt)
        return jsonify({"result": response.text})
    except Exception as e:
        return jsonify({"result":e})




@app.route("/flashcards", methods=["GET"])
def generate_flashcards():
    topic = str(request.args.get("topic", "General Knowledge"))  
    number = int(request.args.get("number", 10))
    
    prompt = (
        f"Generate {number} flashcard questions and answers about {topic}. "
        "Format each as a JSON array where each element is an object with 'question' and 'answer' keys. "
        "Example format: [{'question': 'Q1', 'answer': 'A1'}, {'question': 'Q2', 'answer': 'A2'}] "
        "Questions should cover key concepts. Answers should be concise but informative. "
        "Return ONLY the JSON array, no additional text or explanations."
    )
    
    try:
        response = model.generate_content(prompt)
        json_str = re.sub(r'[`*]|json', '', response.text).strip()
        return jsonify({"flashcards": json.loads(json_str)})
    except Exception as e:
        return jsonify({"error": str(e)})


if __name__=="__main__":
    app.run(debug=True)