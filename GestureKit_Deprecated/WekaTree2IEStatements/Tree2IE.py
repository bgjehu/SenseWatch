#!/usr/bin/python

__author__ = 'SharpPug'
import os
from os.path import basename

def treeToIfElse(filename):
    scriptDir = os.path.dirname(os.path.realpath(__file__))
    treeFilePath = scriptDir + "/" + filename + ".tree"
    treeFile = open(treeFilePath, 'r')
    tempFilePath = scriptDir + "/temp"
    tempFile = open(tempFilePath, 'w')
    lines = list(treeFile)
    stack = []

    LT = "<"
    if LT not in lines[0]:
        LT = "<="

    for line in lines:
        #   get rid of "|" alignment sign
        line = line.replace("|"," ")
        #   get rid of "(xx.xx/xx.xx)"
        if "(" in line:
            line = line[0:line.index("(")] + "\n"
        if LT in line:
            #   replace "x <" to "if x <"
            line = line.replace("x","if x").replace("y","if y").replace("z","if z")
        else:
            #   replace "x >" to "else {"
            xyzIndex = line.find("x")+line.find("y")+line.find("z")+2
            if ":" in line:
                line = line[0:xyzIndex] + "else {" + line[line.index(":"):]
            else:
                line = line[0:xyzIndex] + "else {\n"

        #   get rid of ":"
        line = line.replace(":","")

        #   replace "gesture" to "return gesture"
        gestures = ["PUSH","LEFT","RIGHT","UP","DOWN","NONE"]
        gesturesFix = ["GKGesture.Push","GKGesture.Left","GKGesture.Right","GKGesture.Up","GKGesture.Down","nil"]
        for index in range(0,6,1):
            if gestures[index] in line:
                #   js syntax
                #   line = line.replace(gestures[index],"return " + gesturesFix[index] + "; }")
                line = line.replace(gestures[index],"return " + gesturesFix[index] + " }")

        #   add "{" in if line
        if "if" in line:
            newLine = ""
            for index in range(0,len(line),1):
                char = line[index]
                '''
                    js syntax
                if char.isdigit():
                    if line[index + 1] == " " or line[index + 1] == "\n":
                        char = char + ") {"
                else:
                    if char == "x" or char == "y" or char == "z":
                        char = "(" + char
                '''
                if char.isdigit():
                    if line[index + 1] == " " or line[index + 1] == "\n":
                        char = char + " {"
                newLine += char

            line = newLine
        tempFile.write(line)

    treeFile.close()
    tempFile.close()
    treeFilePath = scriptDir + "/" + filename + ".txt"
    treeFile = open(treeFilePath, 'w')
    lines = list(open(tempFilePath, 'r'))
    for line in lines:
        if "{" in line and "}" in line:
            if "else" in line:
                counter = 0
                while len(stack) > 0:
                    counter += 1
                    last = stack[-1]
                    if counter > 1:
                        line += "\n"
                    line += "}"
                    stack.pop(-1)
                    if last == 'i':
                        line += "\n"
                        break
        else:
            if "if" in line:
                stack.append('i')
            else:
                stack.append('e')

        treeFile.write(line)

    tempFile.close()
    treeFile.close()
    os.remove(tempFilePath)
def convertAllTrees():
    scriptDir = os.path.dirname(os.path.realpath(__file__))
    for subdir, dirs, files in os.walk(scriptDir):
        for file in files:
            info = file.split(os.extsep, 1)
            fileName = info[0]
            extension = info[1]
            if extension == "tree":
                treeToIfElse(basename(fileName))

convertAllTrees()