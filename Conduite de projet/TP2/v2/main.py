import json
import sys

Lemotion = ["joy", "sadness", "anger", "fear", "disgust", "surprise"]
Lconfidence = ["low", "medium", "high"]
LallowedActions = [
    "continue",
    "slow_down",
    "ask_clarification",
    "offer_support",
    "de_escalate",
    "suggest_pause",
]


def react(emotion: str, confidence: str) -> tuple[str, str]:
    if emotion not in Lemotion:
        return (
            "ask_clarification",
            "Your emotion is not valid. Valid emotions are: " + ",".join(Lemotion),
        )

    if confidence not in Lconfidence:
        return (
            "ask_clarification",
            "Your confidence is not valid. Valid confidences are: "
            + ",".join(Lconfidence),
        )

    if confidence == "low":
        return ("ask_clarification", "Can you tell me more?")

    if emotion == "joy":
        if confidence == "medium":
            return ("continue", "You can continue!")
        elif confidence == "high":
            return ("continue", "You can continue!!!")

    if emotion == "sadness":
        if confidence == "medium":
            return ("offer_support", "How do you feel deep inside?")
        elif confidence == "high":
            return (
                "offer_support",
                "You seem very sad. Maybe you need help, we should talk a bit before continuing?",
            )

    if emotion == "anger":
        if confidence == "medium":
            return ("slow_down", "Let us slow down a little.")
        elif confidence == "high":
            return (
                "de_escalate",
                "This feels intense. Maybe we should pause and reflect.",
            )

    if emotion == "fear":
        if confidence == "medium":
            return ("slow_down", "We will slow down a little.")
        elif confidence == "high":
            return (
                "offer_support",
                "Everything will be okay, i'm here. Let us talk together for a while.",
            )

    if emotion == "disgust":
        if confidence == "medium":
            return ("slow_down", "We will take our time.")
        elif confidence == "high":
            return (
                "de_escalate",
                "Something seems wrong. Maybe we should pause and clarify.",
            )

    if emotion == "surprise":
        if confidence == "medium":
            return ("continue", "Let us continue together.")
        elif confidence == "high":
            return (
                "continue",
                "It is surprising! Let us continue and explore it together.",
            )

    return ("ask_clarification", "Can you clarify your feelings?")


def enforce_message_constraints(message: str, state: str) -> str:
    lower_msg = message.lower()

    if state == "SUPPORT":
        if not any(word in lower_msg for word in ["help", "support", "here"]):
            message = message.rstrip() + " I am here to help and support you."
    elif state == "DEESCALATE":
        if not any(word in lower_msg for word in ["calm", "pause", "slow"]):
            message = message.rstrip() + " Let us pause and stay calm."

    if not message.strip():
        message = "I am here."

    return message


def main(inputfile, outputfile):
    current_state = "START"
    output_lines = []
    line_count = 0

    try:
        with open(inputfile, "r") as f:
            for line in f:
                line_count += 1
                line = line.strip()
                if not line:
                    print(f"line {line_count} ignorée: ligne vide")
                    continue
                try:
                    data = json.loads(line)
                except json.JSONDecodeError:
                    print(f"ligne {line_count} ignorée: invalid JSON")
                    continue
                if not isinstance(data, dict):
                    print(f"ligne {line_count} ignorée: JSON object attendu, et non {type(data).__name__}")
                    continue
                missing_keys = [key for key in ["emotion", "confidence"] if key not in data]
                if missing_keys:
                    print(f"ligne {line_count} ingnorée: clé manquante: {missing_keys}")
                    continue

                emotion = data.get("emotion", "")
                confidence = data.get("confidence", "")

                action, message = react(emotion, confidence)

                if current_state == "END":
                    next_state = "END"
                else:
                    if action == "offer_support":
                        next_state = "SUPPORT"
                    elif action == "de_escalate":
                        next_state = "DEESCALATE"
                    elif action == "suggest_pause":
                        next_state = "END"
                    else:
                        next_state = current_state

                message = enforce_message_constraints(message, next_state)

                output = {
                    "action": action,
                    "message": message,
                    "next_state": next_state,
                }

                output_lines.append(json.dumps(output))

                current_state = next_state

        with open(outputfile, "w") as out_f:
            out_f.write("\n".join(output_lines) + "\n")

        print(f"Success: output file created: {outputfile}")

    except IOError:
        print(f"Error: could not read file: {inputfile}")


if __name__ == "__main__":
    if len(sys.argv) <= 1:
        print(f"Usage: python3 {sys.argv[0]} <inputfile.json> [outputfile.json]")
        sys.exit(1)

    inputfile = sys.argv[1]
    outputfile = sys.argv[2] if len(sys.argv) == 3 else "output.json"

    main(inputfile, outputfile)