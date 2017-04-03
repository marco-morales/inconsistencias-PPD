
Este repositorio contiene los materiales necesarios para analizar la llamada *Base CIDE-PPD* presentada por el [Programa de Pol&iacute;tica de Drogas (PPD)](http://www.politicadedrogas.org/) del [Centro de Investigaci&oacute;n y Docencia Econ&oacute;micas (CIDE)](http://cide.edu/) que se presume contiene "registros oficiales" al ser una extensi&oacute;n de la base de datos que la Vocer&iacute;a de Seguridad del Gobierno Federal presentara en 2011.

El prop&oacute;sito de las indagaciones documentadas en este repositiorio no es pronunciarse sobre la "veracidad" del contenido o el origen de estos datos. Esa es responsabilidad &eacute;tica y acad&eacute;mica del PPD.  

**Nuestro prop&oacute;sito es evaluar la congruencia entre las declaraciones de los voceros del PPD y el contenido de sus propios datos**. Si los datos provienen efectivamente de registros oficiales, el an&aacute;lisis puede informar los debates pol&iacute;ticos y de pol&iacute;tica p&uacute;blica en curso. Si no lo son, al menos habremos tenido discusiones metodol&oacute;gicas y estad&iacute;sticas que seguramente ser&aacute;n de utilidad para las comunidades acad&eacute;mica, de activistas, y de donantes.


## Contenido

El repositorio contiene los materiales necesarios para replicar gr&aacute;ficos y an&aacute;lisis publicados en:

* el art&iacute;culo ["Letalidad: lo que el CIDE quiso decir"](articles/RevistaR.pdf) publicado en la [Revista R](http://www.reforma.com/libre/acceso/acceso.htm?urlredirect=/revistar/) de [Reforma](http://www.reforma.com/) el domingo 26 de marzo de 2017. 

En t&eacute;rminos m&aacute;s generales, el repositorio contiene:

* las [bases de datos](data/raw) como fueron descargadas del sitio del PPD
* la [base de datos transformada](data/processed) para su exploraci&oacute;n y an&aacute;lisis 
* el c&oacute;digo para [transformar los datos](src/data)
* el c&oacute;digo para [generar los descriptivos](src/analysis)
* el c&oacute;digo para [generar los gr&aacute;ficos](src/visualizations) 
* los [gr&aacute;ficos](reports/graphs/RevistaR) que ilustran los puntos del art&iacute;culo

Adicionalmente, el repositiorio contiene breves presentaciones tem&aacute;ticas con fines did&aacute;cticos basadas en los datos del PPD:

* [&iquest;qu&eacute; puede inferirise realmente sobre "letalidad" de las fuerzas armadas usando la base de datos del PPD?](reports/documents/InferenciasBaseCIDEPPD.pdf)
* [&iquest;Por qu&eacute; el "&iacute;ndice de letalidad" no mide lo que creemos?](reports/documents/IndiceDeLetalidad.pdf)


## Para replicar

1. Descargar el repositorio completo en la computadora
	* utilizar el c&oacute;digo para replicar cada paso de la transformaci&oacute;n y el an&aacute;lisis
		* para validar los c&oacute;mputos y transformaciones
		* generar an&aacute;lisis propios transformando el c&oacute;digo
	* utilizar s&oacute;lo la base de datos procesada para 
2. [Clonar el repositorio](https://help.github.com/articles/cloning-a-repository/) y [suscribirse a &eacute;l]() para recibir notificaciones de cada actualizaci&oacute;n. 

## Licencia de uso

Dado que el prop&oacute;sito de este repositorio es motiviar el an&aacute;lisis riguroso de esta base de datos, el contenido puede utilizarse bajo la licencia de uso [Creative Commons Attribution 3.0](https://creativecommons.org/licenses/by/3.0/us/), y el c&oacute;digo bajo la [licencia de uso MIT](https://opensource.org/licenses/mit-license.php).

Son bienvenidas las contribuciones a este repositorio.
