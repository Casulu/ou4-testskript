import sys
import matplotlib.pyplot as plt
import numpy as np

testTitles =  ["Insert test", "Remove all test", "Non-existent lookup test", "Random lookup test", "Skewed lookup test"]
class Implementation:

    def __init__(self, title: str, testData, predictions):
        self.predictions = predictions
        self.title = title
        loadedFile = np.loadtxt(testData, delimiter=",")
        self.testData = np.zeros((int(loadedFile.shape[0]/5), 2, 5), np.int32)
        for i in range(5):
            self.testData[:,:,i] = np.delete(loadedFile[np.nonzero(loadedFile[:, 0] == i+1)], 0, 1)
        self.elementAmounts = np.unique(self.testData[:, 0, 0])
        self.avgData = np.zeros((self.elementAmounts.size, 2, 5), np.int32)
        for i in range(5):
            j = 0
            for amount in self.elementAmounts:
                self.avgData[j, 1, i] = np.mean(self.testData[self.testData[:, 0, i] == amount, 1, i])
                self.avgData[j, 0] = amount
                j = j + 1

def plotTimeFunction(implementations: list[Implementation], figureIndex): 
    titles: list[str] = []
    for imp in implementations:
        titles.append(imp.title)

    for i in range(5):
        #plt.subplot(321 + i)
        f = plt.figure(i + figureIndex)
        figureIndex = figureIndex + 1
        plt.title(testTitles[i])
        for imp in implementations:
            plt.plot(imp.avgData[:, 0, i], imp.avgData[:, 1, i] / imp.avgData[:, 0, i])
        plt.legend(titles)
        f.canvas.set_window_title("Time function")

def plotPredictions(implementations: list[Implementation], figureIndex):
    titles: list[str] = []
    for imp in implementations:
        titles.append(imp.title)

    for i in range(5):
        #plt.subplot(321 + i)
        f = plt.figure(i + figureIndex)
        figureIndex = figureIndex + 1
        plt.title(testTitles[i])
        for imp in implementations:
            predictedTimes = np.array([imp.predictions[i](xi) for xi in imp.avgData[:, 0, i]])
            plt.plot(imp.avgData[:, 0, i], (imp.avgData[:, 1, i] / imp.avgData[:, 0, i]) / predictedTimes)
        plt.legend(titles)
        f.canvas.set_window_title("Prediction")

def plotRaw(implementations: list[Implementation], figureIndex):
    titles: list[str] = []
    for imp in implementations:
        titles.append(imp.title)

    for i in range(5):
        #plt.subplot(321 + i)
        f = plt.figure(i + figureIndex)
        figureIndex = figureIndex + 1
        plt.title(testTitles[i])
        for imp in implementations:
            plt.scatter(imp.testData[:, 0, i], imp.testData[:, 1, i] / imp.testData[:, 0, i])
            plt.plot(imp.avgData[:, 0, i], imp.avgData[:, 1, i] / imp.avgData[:, 0, i])
        plt.legend(titles)
        f.canvas.set_window_title("Scatter plot")

def combinePlot(implementations: list[Implementation], figureIndex):
    titles: list[str] = []
    for imp in implementations:
        titles.append(imp.title)

    for imp in implementations:
        #plt.subplot(321 + i)
        f = plt.figure(implementations.index(imp) + figureIndex)
        figureIndex = figureIndex + 1
        plt.title(imp.title)
        for i in range(5):
            plt.plot(imp.avgData[:, 0, i], imp.avgData[:, 1, i] / imp.avgData[:, 0, i])
        plt.legend(testTitles)
        f.canvas.set_window_title("Combined plot")

arr = Implementation("Array table", open(f'array.txt', 'rb'), [lambda x : x, lambda x : x, lambda x : x, lambda x : x, lambda x : x])
mtf = Implementation("MTF table", open(f'mtf.txt', 'rb'), [lambda x : 1, lambda x : x, lambda x : x, lambda x : x, lambda x : x])
dlist = Implementation("Dlist table", open(f'dlist.txt', 'rb'), [lambda x : 1, lambda x : x, lambda x : x, lambda x : x, lambda x : x])

plotTimeFunction([dlist, mtf, arr], 0)
plotPredictions([dlist, mtf, arr], 5)
plotRaw([dlist, mtf, arr], 10)
combinePlot([dlist, mtf, arr], 15)
plt.show()
