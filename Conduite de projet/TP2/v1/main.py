import json
import sys



Lemotion: list[str] = ["joy", "sadness", "anger", "fear", "disgust", "surprise"]
Lconfidence: list[str] = ["low", "medium", "high"]
LallowedActions: list[str] = ["continue", "slow_down", "ask_clarification", "offer_support", "de_escalate", "suggest_pause"]
Lstates: list[str] = ["START", "SUPPORT", "DEESCALATE", "END"]



def react(emotion: str, confidence: str) -> tuple[str, str]:
    if emotion not in Lemotion:
        return (LallowedActions[2], f"Your emotion isn't valid. Here's valid emotions : {','.join(Lemotion)}")
    
    if confidence not in Lconfidence:
        return (LallowedActions[2], f"Your confidence isn't valid. Here's valid confidences : {','.join(Lconfidence)}")

    if confidence == Lconfidence[0]:
        return (LallowedActions[2], "Can you tell me more?")

    if emotion == Lemotion[0]:
        if confidence == Lconfidence[1]:
            return (LallowedActions[0], "You can continue!")
        elif confidence == Lconfidence[2]:
            return (LallowedActions[0], "You can continue!!!")

    if emotion == Lemotion[1]:
        if confidence == Lconfidence[1]:
            return (LallowedActions[3], "Before all, how do you feel deep inside?")
        elif confidence == Lconfidence[2]:
            return (LallowedActions[3], "You look very sad, maybe we need to talk a little bit before continue?")

    if emotion == Lemotion[2]:
        if confidence == Lconfidence[1]:
            return (LallowedActions[1], "Ok i think we will slow down a little.")
        elif confidence == Lconfidence[2]:
            return (LallowedActions[4], "I think this is going a bit too far, don't you think?")

    if emotion == Lemotion[3]:
        if confidence == Lconfidence[1]:
            return (LallowedActions[1], "Don't worry we will slow down a little.")
        elif confidence == Lconfidence[2]:
            return (LallowedActions[3], "No worries, everything will be ok, let's talk together for some time.")

    if emotion == Lemotion[4]:
        if confidence == Lconfidence[1]:
            return (LallowedActions[1], "Chill, we will take our time.")
        elif confidence == Lconfidence[2]:
            return (LallowedActions[4], "Wow, what's the problem here? maybe we didn't understand everything the same way.")

    if emotion == Lemotion[5]:
        if confidence == Lconfidence[1]:
            return (LallowedActions[0], "Let's continue together.")
        elif confidence == Lconfidence[2]:
            return (LallowedActions[0], "Yes, it's surprising haha! let's continue and you will understand.")

    return (LallowedActions[2], "I need more information.")



def main(filename, outputname):
    try:
        with open(filename, "r") as file:
            try:
                formatedJson = json.load(file)
            except:
                print(f"{filename} isn't a valid json file")
                return

            output = []
            current_state = Lstates[0]
            cpt = 1

            for val in formatedJson:
                if 'emotion' not in val or 'confidence' not in val or 'user_text' not in val or not str(val.get('user_text', '')).strip():
                    print(f"A line is incorrect because a key is missing or 'user_text' is empty (object number {cpt}), the line is skiped")
                    cpt += 1
                    continue

                action, message = react(val['emotion'], val['confidence'])

                if current_state == Lstates[3]:
                    next_state = Lstates[3]
                elif action == LallowedActions[3]:
                    next_state = Lstates[1]
                elif action == LallowedActions[4]:
                    next_state = Lstates[2]
                elif action == LallowedActions[5]:
                    next_state = Lstates[3]
                else:
                    next_state = current_state

                msg_lower = message.lower()
                if next_state == Lstates[1]:
                    if not any(word in msg_lower for word in ["help", "support", "here"]):
                        message += " I am here to support you."
                elif next_state == Lstates[2]:
                    if not any(word in msg_lower for word in ["calm", "pause", "slow"]):
                        message += " Please stay calm and let's slow down."

                output.append({
                    'action': action,
                    'message': message,
                    'next_state': next_state
                })
                
                current_state = next_state
                cpt += 1

            with open(outputname, "w") as outputFile:
                outputFile.write(json.dumps(output))

            print(f"Success : output file name : {outputname}")
    except IOError:
        print(f"Error : could not read file : {filename}")



if __name__ == "__main__":
    if len(sys.argv) <= 1:
        print(f"Error : usage : <{sys.argv[0]}> <inputfile.json> [<outputfile.json>]")
    elif len(sys.argv) == 3:
        main(sys.argv[1], sys.argv[2])
    else:
        main(sys.argv[1], "output.json")