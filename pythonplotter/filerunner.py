#!/bin/python3
import os
import matplotlib.pyplot as plt
import numpy as np

def splitTests(rawFile):
    loadedFile = np.loadtxt(rawFile, delimiter=",")
    tests = []
    for i in range(5):
        tests.append(np.delete(loadedFile[np.nonzero(loadedFile[:, 0] == i+1)], 0, 1))
    return tests

def plotTimeFunction(dataList):
    i = 0
    for data in dataList:
        plt.figure(i)
        i = i + 1
        plt.plot(data[0], data[0])
    plt.show()

plotTimeFunction(splitTests(open('raw.txt', 'rb')))
