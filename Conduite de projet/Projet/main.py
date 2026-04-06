import json
from model import process_json_request

class Oracle:
    def __init__(self):
        pass

    def detect(self, text: str, current_action: str) -> dict:
        payload = json.dumps({
            "user_text": text, 
            "current_system_action": current_action
        })

        return json.loads(process_json_request(payload))

class DialogueManager:
    def __init__(self):
        self.messages = {
            "continue": "Je comprends, continuons",
            "ask_clarification": "Pouvez-vous m'en dire plus ?",
            "slow_down": "Prenons un instant pour réfléchir",
            "offer_support": "Je suis là pour vous soutenir",
            "de_escalate": "Restons calme et analysons la situation",
            "suggest_pause": "Vous devriez prendre une pause",
            "acknowledge": "Je comprends ce que vous ressentez",
            "encourage": "C'est très positif, je vous écoute"
        }

    def get_reply(self, analysis: dict) -> dict:
        action = analysis["next_system_action"]

        return {
            "action": action,
            "message": self.messages.get(action, "Pouvez-vous m'en dire plus ?"),
            "detected_emotion": analysis["mapped_vad_state"],
            "vad_scores": analysis["vad_scores"]
        }

class Chatbot:
    def __init__(self):
        self.oracle = Oracle()
        self.dialogue = DialogueManager()
        self.current_action = "ask_clarification"

    def process(self, user_input: str):
        analysis = self.oracle.detect(user_input, self.current_action)

        response = self.dialogue.get_reply(analysis)

        self.current_action = response["action"]

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