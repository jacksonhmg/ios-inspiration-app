from flask import Flask, request, jsonify, send_file
import os
from dotenv import load_dotenv
from elevenlabs import clone, generate, play, set_api_key
from elevenlabs.api import History
import requests

load_dotenv()

XI_API_KEY = os.getenv('XI_API_KEY')

set_api_key(XI_API_KEY)

url = "https://api.elevenlabs.io/v1/voices"

headers = {
  "Accept": "application/json",
  "xi-api-key": XI_API_KEY
}

response = requests.get(url, headers=headers)

print(response.text)

# voice id of dude: W4FK71cS2ISzpdIlRaFe


# app = Flask(__name__)

# @app.route('/generate_audio', methods=['POST'])
# def generate_audio():
#     text = request.json.get('text')
    
#     # Use Eleven Labs (or equivalent) to generate the audio from text.
#     audio_path = ell.generate_audio(text)  # hypothetical function
    
#     return send_file(audio_path, as_attachment=True, attachment_filename='response.mp3')

# if __name__ == "__main__":
#     app.run(debug=True)
