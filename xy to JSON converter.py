import json


xCord = 0
yCord = 0


coordinateFile = "PUT THE FILE TO BE CONVERT PATH HERE" #input
JSONfile="PUT THE JSON FILE PATH HERE" #output


def readFile():
    #read file
    file = open(coordinateFile, "r")
    lines = file.readlines()
    file.close
    
    #look for patterns
    for line in lines:
        line = line.strip()
        if line.find(",")!= -1: #if there is a comma at this line
            
            divider = line.find(",") #finding position of comma 
            xCord = line.split(",")[0]
            xCord = int (xCord)
            #print (xCord)
            
            yCord = line.split(",")[1]
            yCord = int (yCord)
            #print (yCord)

            dictionary = {
                "x": xCord,
                "y": yCord
            }
            
            
            with open(JSONfile) as json_file: 
                data = json.load(json_file) 
                
                temp = data['drawing'] 
                # appending data to emp_details  
                temp.append(dictionary) 
                
            write_json(data)  
            

        else: 
            print("no comma at"+ line)
    #display result

# function to add to JSON 
def write_json(data): 
    with open(JSONfile,'w') as f: 
        json.dump(data, f, indent=4) 

readFile()
