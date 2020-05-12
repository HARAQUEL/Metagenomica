Este repositorio contiene un script (directorio bin) para analizar datos de muestras de hongos obtenidos de la plataforma Illumina MiSeq. 
Los datos corresponden a 24 muestras de suelo rizosférico recolectados en sitios de bosque nativo (N) y mixto (M) de Quercus (Q) y de Juniperus (J). Al final del tutorial se obtuvo una tabla de OTUs en formato .biom (directorio data) con un min_lenght de secuencias de 200 bp. La opción min_lenght permite definir la longitud mínima de la alineación. Las secuencias más cortas que la longitud mínima no serán consideradas, y las alineaciones que sean más cortas serán ignoradas.

En comparación con el archivo .biom que contiene un min_lenght de secuencias de 300 bp, el archivo .biom con un min_lenght de secuencias de 200 bp quizás represente una ventaja sobre el primero (de 300 pb), ya que no se están eliminando secuencias que tengan > 200 pb y que podrían brindar información de las muestras de suelo; esta información no se aprovecharía si eligiéramos la opción de min_lenght 300 bp, ya que estamos siendo muy estrictos en la selección de longitud de secuencias y sólo estamos eligiendo aquellas que se secuenciaron completamente (lenght of reads 300 pb).




