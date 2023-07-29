
import pylab as plt
import seaborn as sns
import re
import pandas as pd


#Ploteo de valores nulos:

def nanplot(df):  
    
    plt.figure(figsize = (10, 6))
    sns.heatmap(df.isna(),
                yticklabels = False,
                cmap ='viridis',
                cbar = False,  
                )
    plt.show()

    
# Resaltado de celdas en un dataframe
    
def yellow(df, index, cols): # Los inputs son el dataframe, una lista de índices y una lista de columnas
    
    m = pd.DataFrame('', index = df.index, columns = df.columns) # Creamos un df vacío de iguales dimensiones
    for i,col in zip(index,cols):
        m.loc[i, col] = 'background-color: yellow' # En las celdas indicadas, guardamos el style amarillo

    styled_df = df.style.apply(lambda x: m, axis = None) # Aplicamos el styling de 'm' al dataframe 

    return styled_df
   
   
 
# Función de análisis inicial de un dataframe desconocido, printea información básica
   
def firstglance(df):
    
    display(df.head())
    print("\nShape:",df.shape)
    print("\nNull values count:\n")
    print(df.isna().sum())
    print("\nTable info:\n")
    display(df.info())

