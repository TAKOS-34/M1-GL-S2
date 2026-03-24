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
        self.actions = ["continue", "slow_down", "ask_clarification", "offer_support", "de_escalate"]
        self.messages = [
            "Je comprends, continuons.",
            "Pouvez-vous m'en dire plus ?",
            "Prenons un instant pour réfléchir.",
            "Je suis là pour vous soutenir.",
            "Restons calme et analysons la situation."
        ]

    def get_reply(self, analysis: dict) -> dict:
        return {
            "action": random.choice(self.actions),
            "message": random.choice(self.messages),
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
        entry = input("Utilisateur : ")
        if (entry.lower() == "quit"):
            print("Au revoir !")
            break

        result = bot.process(entry)
        print(f"Chatbot: {json.dumps(result, indent=4)}")