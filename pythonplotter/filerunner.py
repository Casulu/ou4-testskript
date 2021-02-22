#!/bin/python3
import os
import matplotlib.pyplot as plt
import numpy as np

def splitTests(rawFile):
    loadedFile = np.loadtxt(rawFile, delimiter=",")
    tests = np.zeros((int(loadedFile.shape[0]/5), 2, 5), np.int32)
    for i in range(5):
        tests[:,:,i] = np.delete(loadedFile[np.nonzero(loadedFile[:, 0] == i+1)], 0, 1)
    return tests

def averageData(data):
    elementAmounts = np.unique(data[:, 0, 0])
    avg = np.zeros((elementAmounts.size, 2, 5), np.int32)
    for i in range(5):
        j = 0
        for amount in elementAmounts:
            avg[j, 1, i] = np.mean(data[data[:, 0, i] == amount, 1, i])
            avg[j, 0] = amount
            j = j + 1
    return avg

def plotTimeFunction(titles, dataList): 
    for i in range(5):
        plt.figure(i)
        plt.title(f"Test {i+1}")
        for data in dataList:
            plt.plot(data[:, 0, i], data[:, 1, i])
        plt.legend(titles)
    plt.show()

arr = splitTests(open('rawarray.txt', 'rb'))
mtf = splitTests(open('rawmtf.txt', 'rb'))
mtfAvg = averageData(mtf)
arrAvg = averageData(arr)

plotTimeFunction(["Mtf", "Array"],[mtfAvg, arrAvg])
