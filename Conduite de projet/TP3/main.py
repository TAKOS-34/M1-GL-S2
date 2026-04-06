import random
import json

class Oracle:
    def __init__(self):
        self.emotions = ["joy", "sadness", "anger", "fear", "disgust", "surprise"]
        self.confidences = ["low", "medium", "high"]

    def detect(self, text: str) -> dict:
        return {
            "emotion": random.choice(self.emotions),
            "confidence": random.choice(self.confidences)
        }

class DialogueManager:
    def __init__(self):
        self.messages = {
            "continue": "Je comprends, continuons",
            "ask_clarification": "Pouvez-vous m'en dire plus ?",
            "slow_down": "Prenons un instant pour réfléchir",
            "offer_support": "Je suis là pour vous soutenir",
            "de_escalate": "Restons calme et analysons la situation",
            "suggest_pause": "Vous devriez prendre une pause"
        }

    def get_reply(self, analysis: dict) -> dict:
        action = random.choice(list(self.messages.keys()))

        return {
            "action": action,
            "message": self.messages[action],
            "detected_emotion": analysis["emotion"],
            "confidence": analysis["confidence"]
        }

class Chatbot:
    def __init__(self):
        self.oracle = Oracle()
        self.dialogue = DialogueManager()

    def process(self, user_input: str):
        analysis = self.oracle.detect(user_input)

        response = self.dialogue.get_reply(analysis)

        return response

if __name__ == "__main__":
    bot = Chatbot()

    while True:
        entry = input("Utilisateur (tapez 'quit' pour sortir) : ")
        if (entry.lower() == "quit"):
            print("Au revoir !")
            break

        result = bot.process(entry)
        print(f"Chatbot: {json.dumps(result, indent=4)}")