import json
import sys



Lemotion: list[str] = ["joy","sadness","anger","fear","disgust","surprise"]
Lconfidence:list[str] = ["low", "medium", "high"]
LallowedActions:list[str] =  ["continue", "slow_down", "ask_clarification", "offer_support", "de_escalate", "suggest_pause"]



def react(emotion: str, confidence: str) -> tuple[str,str]:
    if emotion not in Lemotion:
        return (LallowedActions[2], f"Your emotion isn't valid. Here's valid emotions : {','.join(Lemotion)}")
    
    if confidence not in Lconfidence:
        return (LallowedActions[2], f"Your confidence isn't valid. Here's valid confidences : {','.join(Lconfidence)}")

    if confidence == Lconfidence[0]:
        return (LallowedActions[2], "Can you tell me more ?")

    if emotion == Lemotion[0]:
        if confidence == Lconfidence[1]:
            return(LallowedActions[0],"You can continue !")
        elif confidence == Lconfidence[2]:
            return(LallowedActions[0],"You can continue !!!")

    if emotion == Lemotion[1]:
        if confidence == Lconfidence[1]:
            return(LallowedActions[3],"Before all, how do you fell deep inside ?")
        elif confidence == Lconfidence[2]:
            return(LallowedActions[3],"You look very sad, maybe we need to talk a little bit before continue ?")

    if emotion == Lemotion[2]:
        if confidence == Lconfidence[1]:
            return (LallowedActions[1],"Ok i think we will slow down a little.")
        elif confidence == Lconfidence[2]:
            return (LallowedActions[4],"I think this is going a bit too far, don't you think ?")

    if emotion == Lemotion[3]:
        if confidence == Lconfidence[1]:
            return(LallowedActions[1],"Don't worry we will slow down a little.")
        elif confidence == Lconfidence[2]:
            return (LallowedActions[3],"No worries, everything will be ok, let's talk together for some time.")

    if emotion == Lemotion[4]:
        if confidence == Lconfidence[1]:
            return (LallowedActions[1],"Chill, we will take our time.")
        elif confidence == Lconfidence[2]:
            return(LallowedActions[4],"Wow, what's the problem here? maybe we didn't understand everything the same way.")

    if emotion == Lemotion[5]:
        if confidence == Lconfidence[1]:
            return(LallowedActions[0],"Let's continue together.")
        elif confidence == Lconfidence[2]:
            return(LallowedActions[0],"Yes, it's suprising haha! let's continue and you will understand.")



def main(filename, outputname):
    try:
        with open(filename, "r") as file:
            output = []

            try:
                formatedJson = json.load(file)
            except:
                print(f"{filename} isn't a valid json file")
                return

            cpt = 1

            for val in formatedJson:
                if (not 'emotion' in val.keys()):
                    print(f"A line is incorrect because 'emotion' key is not defined (object number {cpt}), the line is skiped")
                    continue

                if (not 'confidence' in val.keys()):
                    print(f"A line is incorrect because 'confidence' key is not defined (object number {cpt}), the line is skiped")
                    continue

                allowedAction, response = react(val['emotion'], val['confidence'])
                output.append({ 'action': allowedAction, 'message': response })

                cpt += 1

            dump = json.dumps(output)

            with open(outputname, "w") as outputFile:
                outputFile.write(dump)

            print(f"Success : output file name : {outputname}")
    except IOError:
        print(f"Error : could not read file : {filename}")



if __name__ == "__main__":
    if (len(sys.argv) <= 1):
        print(f"Error : usage : <{sys.argv[0]}> <inputfile.json> [<outputfile.json>]")

    if (len(sys.argv) == 3):
        main(sys.argv[1], sys.argv[2])

    else:
        main(sys.argv[1], "output.json")