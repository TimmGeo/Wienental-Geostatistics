### 1. Introduction 

Dans le cadre du cours " Analyses spatiales et quantitatives en géographie " de l'Université de Lausanne, une étude du territoire de la région du Wynental est réalisée dans ce rapport. La région du Wynental, située au sud du canton d'Argovie, a été définie comme lieu d'étude. 

Ce TP2 est la suite du premier travail pratique qui était terminé en Novembre 2022. Ce nouveau travail porte à nouveau sur la même région (Région Wynental), sauf que le TP2 présente l'utilisation d'autres outils statistiques pour compléter l'étude territoriale.

Le fil conducteur de ce travail est l'idée d'avoir été mandaté par la commune d'Unterkulm (chef-lieu du district de Kulm) en tant que collaborateur scientifique et géographe pour étudier la région du Wynental à différents niveaux

![**Figure 1**: Région du Wynental](../figures_rmarkdown/figure1_wynental.png)

Plus concrètement, le TP2 porte sur les analyses suivantes: 

- une **[2. Régression logistique multinomiale]**
- une **[3. Analyse en composants principales (ACP)]**
- et cette ACP est suivi d'une **[4. Classification ascendante hierarchique (CAH)]**

### 2. Régression logistique multinomiale
La première analyse à effectuer dans le cadre du TP2 est une régression logistique multinomiale comme expliqué auparavant. Le principe de la régression logistique multinomiale est d'expliquer ou de **prédire une variable** qui peut prendre J valeurs alternatives (les J modalités de la variable) en fonction de **variables explicatives**. 

### 2.1 But de cette étappe
L'objectif de cette étape est de construire un modèle logistique multinomial qui permet de classer les communes sur la base de variables indépendantes les unes des autres. Ses prédictions seront évaluées et comparées à la typologie des communes (2012) réalisée par l'Office fédéral de la statistique (OFS). 

#### 2.2 Explication de la procedure du calcul
La procédure de facturation est expliquée dans le _Notebook_technique_ parallèle.  

#### 2.3 Procédure de sélection des variables
L'étudiant était libre de choisir la variable qu'il souhaitait. La seule consigne était que cette variable devait être catégorielle et comporter au moins trois classes. Comme le thème de la "ruralité" a déjà été traité dans le TP1, la _typologie des communes de l'OFS de l'année 2012_ a été choisie comme variable. Il s'agit d'une classification des communes suisses en zones urbaines, intermédiaires ou rurales (**Critère des trois classes/catégories donc rempli!**)

##### 2.3.1 Examen du choix de la variable indépendante 
**L'important dans ce choix était de vérifier* que les 25 communes de la région Wynental présentent bien les trois classes/catégories. Pour ce faire, un tableau Excel a été téléchargé via le site Internet de Swisstopo, qui attribue à chaque colonne de communes une colonne de type de commune (Rural, Intermédiaire ou Urbain) (lien des données : https://www.bfs.admin.ch/asset/fr/2543283). En observant et en comparant les catégories et les noms de communes de la région Wynental, il a été possible de constater que la région Wynental possède, selon la typologie des communes établie par l'OFS (2012), aussi bien des zones rurales, des zones agglo que des zones urbaines. Pour cette raison, il n'a pas été nécessaire d'agrandir la région d'étude avec des communes supplémentaires. Il n'y avait donc plus d'obstacle à cette variable, qui a pu être utilisée pour cette recherche. 

- **_Variable_indépendante_** = typologie des communes de l'OFS_  

peut être définie.

##### 2.3.2 Choix des variables explicatives 
**L'enjeu du choix de ces variables était* qu'elles expliquent suffisamment la typologie des communes établie par l'OFS. Il devait donc s'agir de variables qui expliquent ou indiquent d'une part pourquoi une commune est plutôt rurale ou, d'autre part, plutôt urbaine. Les quatre variables suivantes ont été sélectionnées pour cette recherche et leur choix est brièvement expliqué ci-dessous.

- (1) _SAU_: Proportion [%] de la surface agricole utile (en hectar) par rapport à la surface totale de la commune (en hectar) -> _Source des données: Office fédéral de la statistique (Swisstopo), Relevé des structures agricoles STRU (2021)_

La variable SAU est une unité de mesure de la surface agricole utilisée dans les statistiques et l'administration, notamment pour les indicateurs de production tels que les rendements. Elle est souvent exprimée en hectares. Elle comprend les terres arables, les cultures permanentes et les pâturages permanents (Wikipedia, 2020). C'est pourquoi elle est également un bon indicateur de ruralité/urbanité, car elle indique la proportion de terres agricoles par commune. Cette proportion est donc d'autant plus élevée que la commune est rurale, respectivement d'autant plus petite que la commune est urbaine. 

- (2) _EPT1_: Proportion [%] des emplois du secteur primaire par rapport au total des emplois dans la commune -> _Source des données: Office fédéral de la statistique (Swisstopo), Statistique de l'emploi STATEM (2022)_ 

Cette variable a déjà été sélectionnée dans le TP1 et se prête donc particulièrement bien à l'étude de la ruralité des communes. A ce stade, il convient également d'expliquer brièvement la signification des professions "équivalentes à un temps plein". Selon _Wikipedia_, ces professions sont définies comme suit : _"Les professions en équivalent temps plein sont définies comme le nombre d'heures travaillées (dans une entreprise, une région ou un pays) divisé par la durée habituelle de travail d'un employé à temps plein, par exemple 40 heures" (Wikipedia, 2022)_. Dans cette étude par pays, l'indicateur "équivalent temps plein" est plus approprié que l'indicateur "général" pour les professions du premier secteur économique, car il fournit des informations plus précises sur les activités professionnelles dans la région. Il permet par exemple d'éviter les informations trompeuses, comme les cas de professionnels travaillant à temps partiel dans plusieurs professions (Kaiser, 2022). Dans ce cas, "plus de professions" seraient affichées en tant que personnes actives, ce que l'indicateur choisi vise à éviter dans cette étude géographique. 

- (3) _SURFHAB_: Proportion [%] de la surface des batiments d'habitat (ha) par rapport au total de la surface de la commune (ha) -> _Source des données: Office fédéral de la statistique (Swisstopo), Statistique suisse de la superficie (AREA) (2013/18)_

La surface d'habitat a été choisie parce qu'elle fournit une indication sur le fait qu'une zone est moins ou plus urbanisée. On suppose donc que la proportion de la surface d'habitat est relativement importante pour les communes définies par l'OFS comme URBAIN, et faible pour les communes définies comme RURAL.


- (4) _RESSEC_: Proportion [%] des résidents secondaires par rapport à tout les types des batiments dans la commune -> _Source des données: Office fédéral de la statistique (Swisstopo), Dénombrement des logements vacants (2022)_

Le choix de cette dernière variable est justifié par le fait que l'on suppose que la proportion de résidences secondaires est en principe plus élevée dans les régions rurales. 


#### 2.4 Résultats 

##### 2.4.1 Matrice de confusion 

La matrice de confusion est en quelque sorte un résumé des résultats de prédiction pour un problème de classification donné. Elle compare les données réelles pour une variable cible avec les données prédites par un modèle. Les prédictions correctes et incorrectes sont révélées et réparties par classe, de sorte qu'elles peuvent être comparées à des valeurs définies (Jedha, 2021) **Les objets correctement prédits se trouvent sur la diagonale, les objets incorrectement prédits se trouvent dans les autres cellules de la matrice** (de-academic, 2020). 

Sur la base de cette théorie, on peut conclure qu'une valeur s'écarte de cette diagonale, à savoir une commune qui a été classée à tort comme rurale. 

**Nota Bene:** Comme il a déjà été mentionné dans le _notebook_technique_ parallèle, une variable explicative (RESSEC) a été délibérément supprimée afin de pouvoir forcer une erreur dans la matrice de confusion pour représenter au moins une erreur dans la carte des erreurs. 

![**Figure 2:**Matrice de confusion](../figures_rmarkdown/figure2_matrice.png)

##### 2.4.2 Carte des erreurs 

Afin de pouvoir mieux interpréter les résultats de la régression logistique multinomiale, une carte d'erreur est créée. 

Création de la carte : Les données de la prévision exportées par le _notebook_technique_ ont été exportées sous forme de fichier .csv, traitées dans excel et finalement chargées dans le programme QGis. Un nouveau document Excel a ensuite été créé, dans lequel les données de la prévision ont été comparées à la typologie des communes établie par l'OFS. Ligne par ligne, on a vérifié où il y avait un écart entre les deux colonnes. **Enfin, l'erreur a été trouvée pour la commune de Holziken**. Il s'agit d'une commune d'agglomération qui a été prédite à tort comme rurale. Dans le programme graphique Adobe Illustrator, la commune a ainsi été colorée en rouge et la carte d'erreur finalisée, qui est affichée ci-dessous : 

![**Figure 3:**Carte des erreurs](../figures_rmarkdown/figure3_carte_erreurs.png)
Éléments de la carte : 

- **Couleur** (pour la variable relative) pour les prévisions erronées 

#### 2.5 Discussion des résultats et perspectives

Comment les résultats ci-dessus pourraient-ils s'expliquer ? La question se pose donc de savoir pourquoi la région, définie comme agglomération selon la typologie des communes établie par l'OFS (2012), a été classée comme rurale dans la régression logistique multinomiale. Pour interpréter cette erreur, des recherches sont effectuées sur Internet afin de collecter les caractéristiques économiques, culturelles et écologiques de la région. Enfin, dans une deuxième étappe, les valeurs chiffrées des indicateurs de Holziken sont comparées à une autre commune d'agglo dont la typologie a été correctement prédite pour aboutir à une conclusion plus précise et approfondie sur les chiffres.

Holziken se trouve au nord de la région d'étude. La commune fait partie du district de Kulm et est directement adjacente à l'autoroute A1 (entre Zurich et Berne), qui est l'axe de circulation principal de Suisse avec la fréquence de trafic la plus élevée. En effet, la commune a connu un essor économique suite à l'introduction de cette autoroute en 1967. En l'espace d'à peine quarante ans, la population a doublé (Wikipedia, 2021). Holziken se trouve au carrefour de plusieurs routes de liaison locale vers le Suhrental, l'Uerkental et le Wiggertal. La route principale 24 passe à l'est du village et sert à la fois de contournement et de bretelle d'accès à la jonction Aarau-West de l'autoroute A1, située à proximité. La commune est également reliée au chemin de fer du Wynental. 
Cependant, la région est également rurale. En effet, la moitié sud du territoire communal est très vallonnée et presque entièrement recouverte de forêts. La moitié nord, en revanche, se situe dans une plaine totalement plate et intensivement cultivée appelée "Hard". La superficie du territoire communal est de 286 hectares, dont 109 hectares sont boisés et 44 hectares sont construits (Wikipedia, 2021). 
Si l'on considère la commune dans son contexte, on remarque qu'elle est limitrophe de Kölliken au nord-ouest, Muhen au nord-est, Hirschthal à l'est, Schöftland au sud-est et Uerkheim au sud-ouest. Köliken et Schöftland sont définies comme "agglomération" selon la typologie des communes établie par l'OFS (2012). **Dans ce contexte et sur la base des faits déjà mentionnés, il est évident que l'OFS a défini la commune comme une "agglomération "**. 

Mais comment expliquer l'erreur d'attribution de la Régression logistique multinomiale qui consiste à interpréter la commune comme "Rurale" ? Pour cela, il faut rappeler quelles variables ont été choisies pour établir la Régression logistique multinomiale (SAU, EPT1, SURFHAB). **Il n'y a donc que 3 indicateurs utilisés pour la prédiction qui sont statistiquement insuffisants pour établir une classification pertinente et fiable.** Dans cette ligne, il faut tenir compte du fait que la typologie des communes établie par l'OFS a pris en compte une multitude d'indicateurs différents dans sa classification. Ce n'est donc pas un hasard si la commune de Holziken a été classée comme "rurale" dans le cas présent, car l'indicateur de la SAU, avec une part de 40% de terres arables, a déjà un poids important dans la classification. Comme la part des emplois dans le secteur économique primaire et la proportion des surfaces bâties ne sont pas non plus élevées, **on peut en conclure que l'attribution des trois indicateurs utilisés est justifiée**. 

**Pour une conclusion plus précise, les valeurs chiffrées des indicateurs de Holziken pourraient être comparées à une autre commune d'agglo dont la typologie a été correctement prédite**. A ce stade, on peut par exemple prendre la commune de Kölliken. Les valeurs suivantes peuvent être lues ; 0,25 pour la SAU, 0,02 pour l'EPT1 et 0,15 pour la SURFHAB. La commune de Holziken dispose de valeurs de 0,47 pour la SAU, 0,08 pour l'EPT1 et 0,10 pour la SURFHAB. On remarque que la part de la SAU est très élevée pour Holziken (47%) et que les autres valeurs de SURFHAB et EPT1 sont relativement faibles. De même, la valeur de la commune d'agglo de Schöftland, correctement prédite, est, avec 0,19 pour la SAU, bien inférieure à la valeur de Holziken. 


### 3. Analyse en composants principales (ACP)
Après l'achèvement de la régression logistique multinomiale, voici l'analyse en composantes principales (ACP). L'analyse en composantes principales (ACP) est un outil de compression et de synthèse de l'information très utile lorsqu'il s'agit de traiter et d'interpréter une grande somme de données quantitatives (Openeditions, 2018). **L'objectif de l'ACP est de revenir à un espace de dimension réduite en déformant le moins possible la réalité**. Il s'agit donc d'obtenir un **résumé le plus pertinent possible** des données initiales (Wikistat, 2021), en transformant *p* variables corrélées en *p* nouvelles variables non corrélées également appelées **facteurs**, **dimensions** ou **composantes**.

#### 3.1 Explication de la procedure du calcul
La procédure de facturation est expliquée dans le _Notebook_technique_ parallèle.  

#### 3.2 Procédure de sélection des variables

La préparation des données a impliqué une sélection de variables et le calcul des indicateurs. Cette analyse étant indépendante de la régression logistique de l'étape précédente, l'étudiant était ici aussi libre de choisir les variables. Il est néanmoins important que les différentes variables collectées se rapportent à un thème précis. 

Dans cette étude territoriale, les variables collectées se rapportent à l'urbanisation des communes. Il faut s'assurer que ces variables peuvent fonctionner comme des indicateurs, c'est-à-dire qu'elles se rapportent à la structure et non à l'ampleur d'un phénomène (Kaiser, 2022). Cela implique typiquement le calcul de pourcentages.

**N.B:** Comme on peut le voir dans la _notebook_technique_ parallèle, l'ensemble final d'indicateurs est développé de manière itérative au cours de l'analyse. Ainsi, après avoir calculé une première ACP, on examine le résultat et on améliore l'ACP de manière successive, en éliminant et en ajoutant des variables. En effet, dans la pratique, il est nécessaire de sacrifier certaines données afin de disposer d'un cadre d'analyse plus général et plus facile  à généraliser.

Les 11 variables suivantes ont été définies pour une première ACP en rapport avec le thème de l'urbanisation, leur choix est brièvement expliqué : 


- (1) _SAU_: Proportion [%] de la surface agricole utile (en hectar) par rapport à la surface totale de la commune (en hectar) -> _Source des données: Office fédéral de la statistique (Swisstopo), Relevé des structures agricoles STRU (2021)_

La variable SAU est une unité de mesure de la surface agricole utilisée dans les statistiques et l'administration, notamment pour les indicateurs de production tels que les rendements. Elle est souvent exprimée en hectares. Elle comprend les terres arables, les cultures permanentes et les pâturages permanents (Wikipedia, 2020). C'est pourquoi elle est également un bon indicateur de ruralité/urbanité, car elle indique la proportion de terres agricoles par commune. Cette proportion est donc d'autant plus élevée que la commune est rurale, respectivement d'autant plus petite que la commune est urbaine. 

- (2) _EPT1_: Proportion [%] des emplois du secteur primaire par rapport au total des emplois dans la commune -> _Source des données: Office fédéral de la statistique (Swisstopo), Statistique de l'emploi STATEM (2022)_ 


Cette variable a déjà été sélectionnée dans le TP1 et se prête donc particulièrement bien à l'étude de l'urbanisation des communes. A ce stade, il convient également d'expliquer brièvement la signification des professions "équivalentes à un temps plein". Selon _Wikipedia_, ces professions sont définies comme suit : _"Les professions en équivalent temps plein sont définies comme le nombre d'heures travaillées (dans une entreprise, une région ou un pays) divisé par la durée habituelle de travail d'un employé à temps plein, par exemple 40 heures" (Wikipedia, 2022)_. Dans cette étude par pays, l'indicateur "équivalent temps plein" est plus approprié que l'indicateur "général" pour les professions du premier secteur économique, car il fournit des informations plus précises sur les activités professionnelles dans la région. Il permet par exemple d'éviter les informations trompeuses, comme les cas de professionnels travaillant à temps partiel dans plusieurs professions (Kaiser, 2022). Dans ce cas, "plus de professions" seraient affichées en tant que personnes actives, ce que l'indicateur choisi vise à éviter dans cette étude géographique. 

- (3) _SURFHAB_: Proportion [%] de la surface des batiments d'habitat (ha) par rapport au total de la surface de la commune (ha) -> _Source des données: Office fédéral de la statistique (Swisstopo), Statistique suisse de la superficie (AREA) (2013/18)_

La surface d'habitat a été choisie parce qu'elle fournit une indication sur le fait qu'une zone est moins ou plus urbanisée. On suppose donc que la proportion de la surface d'habitat est relativement importante pour les communes définies par l'OFS comme URBAIN, et faible pour les communes définies comme RURAL.

- (4) _RESSEC_: Proportion [%] des résidents secondaires par rapport à tout les types des batiments dans la commune _Source des données: Office fédéral de la statistique (Swisstopo), Dénombrement des logements vacants (2022)_

Le choix de cette variable est justifié par le fait que l'on suppose que la proportion de résidences secondaires est en principe plus élevée dans les régions rurales. 

- (5) _SURFIND_ : Proportion [%] des surfaces industrielles et commerciales par commune (en hectares) par rapport à la surface totale de la commune (en hectares) -> _Source des données: Office fédéral de la statistique (Swisstopo), Statistique suisse de la superficie (AREA) (2013/18)_

La surface industrielle et commerciale a été choisie parce qu'elle fournit une indication sur le fait qu'une région est moins ou plus urbanisée. On suppose donc que la proportion de surface industrielle et commerciale est relativement importante pour les communes définies comme URBAN par l'OFS, et faible pour les communes définies comme RURAL.

- (6) _RETR_: Proportion [%] des résidents qui sont agés +65 -> Sources des données: _Source des données: Office fédéral de la statistique (Swisstopo), Statistique de la population et des ménages STATPOP (2021)_ 

Cet variable a été choisi pour avoir aussi une dimension démographique dans les données 

- (7) _ADO_: Proportion [%] des résidents qui sont entre 10 et 19 ans --> Sources des données: _Source des données: Office fédéral de la statistique (Swisstopo), Statistique de la population et des ménages STATPOP (2021)_  

Cet variable a été choisi pour avoir aussi une dimension démographique dans les données 

- (8) _IP_270920_: Proportion [%] de OUI pour l'initiative populaire "Pour une migration moderée" -> Sources des données: Swisstopo, Statistique des votations et des élections (2020)
- (9) _IP_250916_: Proportion [%] de OUI pour l'initiative populaire "AVSplus: Pour une AVS forte" -> Sources des données: Swisstopo, Statistique des votations et des élections (2016)
- (10) _IP_291120_: Proportion [%] de OUI pour l'initiative populaire «Entreprises responsables – pour protéger l'être humain et l'environnement» -> Sources des données: Swisstopo, Statistique des votations et des élections (2020)
- (11) _IP_130222_: Proportion [%] de OUI pour l'initiative populaire «Oui à l'interdiction de l'expérimentation animale et humaine" -> Sources des données: Swisstopo, Statistique des votations et des élections (2022)

Les variables 8-11 ont étaient choisis pour avoir une dimension politique dans les données. Comme il s'agit d'une région d'étude rurale, l'hypothèse est fait que les résidents votent avec une orientation politique plutot droit. 

#### 3.3 Résultats 

##### 3.3.1 PCA Graph 

Comme expliqué initialement, l'ACP crée de nouvelles dimensions *p* qui expliquent chacune une certaine proportion de la variance. Ceci est montré visuellement avec ce PCA graph et ensuite, sous **[3.3.2 Contribution]** en forme d'un histogramme: 

![**Figure 4:** PCA Graph](../figures_rmarkdown/figure4_PCA_graph.png)

##### 3.3.2 Contribution 

Sous la colonne "Cumulative Variance Percent" du tableau de contribution ci-dessous, on peut voir que 50.8% de la variance est expliquées par la première dimension et que plus de 95% de la variance sont expliquées par les quatre premières dimensions. Le critère d'une ACP qualitative est donc rempli ; **"Pour avoir une bonne ACP, il faut normalement viser une première composante qui explique au moins 50% de la variance, et les quatre premières composantes arrivent à 85% de la variance expliquée" (Kaiser, 2022)**. 

Comme l'objectif de l'ACP est de simplifier les données et de "généraliser de nombreuses variables", il faudrait décider si un nombre réduit de dimensions par rapport au nombre initial d'indicateurs doit etre conservé. Pour cela il existe différents critères qu'il vaut de mentionner ici et de comparer avec les tableaux affichées ci-dessous; 

- Premièrement, le **le critère de Kaiser**: _Ne garder que les dimensions ayant une valeur propre >1_ ; Dans le cas de cette étude ca seraient les 2 premières dimensions. 

- Deuxièmement, le **critère de Cattell**: _Garder les dimensions qui expliquent 80% de la variance_ ; Dans le cas de cette étude ca seraient les 2 premières dimensions pour atteindre 85,45%. 

- Enfin, le **critère de Cattell**: _Détermine le nombre de facteurs en observant un screePlot, en identifiant le point d'inflexion du graphique_ ; Dans ce cas, pour améliorer l'ACP, nous devrions supprimer les indicateurs qui sont plus indépendants et en ajouter d'autres qui sont mieux corrélés avec d'autres indicateurs afin d'obtenir des facteurs qui expliquent mieux les autres indicateurs. 

![**Figure 5:** Contribution](../figures_rmarkdown/figure5_contribution.png)
Le tableau qui permis facilement de trouver les infos sur la variance expliqué des différents dimensions: 
![**Figure 6:** Données numériques](../figures_rmarkdown/figure6_donnees_contri.png)
##### 3.3.3 Communalités 
La communalité d'une variable indique quelle part de la variance de cette variable peut être représentée par l'ensemble des facteurs (Studyflix, 2021). 

![**Figure 7:** Communalités](../figures_rmarkdown/figure7_communalites.png)

##### 3.3.4 Contribution 1ère dimension
En complément du graphique ci-dessus, le graphique suivant présente un histogramme qui permet de visualiser la contribution/le poids de chaque variable à la première dimension. **On peut constater que SURFIND (surface industrielle et commerciale) contribue le plus à la première dimension, respectivement RESSEC le moins...** La proportion de la surface des bâtiments et des emplois du premier secteur économique contribuent également de manière considérable à la première dimension. 

N.B: Un graphique de contribution pour chaque dimension a été fait (voir notebook technique) ce qui permet d'afficher la contribution de chacune des variables à la dimension en particulier.  

![**Figure 8:** Contribution 1dim](../figures_rmarkdown/figure8_contri_1dim.png)


##### 3.3.5 Carte de l'ACP

Pour observer visuellement les tendances spatiales et interpréter la contribution des indicateurs pour chaque commune, une carte ACP a été crée qui permet notamment d'observer les phénomènes démographiques, sociaux, économiques, etc. de la région. 

Création de la carte : Les données exportées par le _notebook_technique_ ont été exportées sous forme de fichier .csv, traitées dans excel et ont pu être finalement chargées dans le programme QGis. Un lien a ensuite été créé entre les communes (shape-file de Swisstopo, 2021) et le tableau Excel. Il a été possible de vérifier si ce lien était réussi dans le tableau d'attribution des communes, où les différentes dimensions des scores factoriels devaient être listées dans la dernière colonne. Après vérification, il est possible de sélectionner sous "Symbology" la graduation dans la classification des pourcentages dans Jenks, après quoi les communes sont classées dans différentes couleurs.

Enfin, la carte indique pour chaque commune le score factoriel obtenu. En d'autres termes, elle montre la contribution de chaque commune à la première dimension. Comme je n'ai réalisé qu'une seule carte et non une carte par dimension, j'ai choisi de prendre la première dimension de l'ACP. 


![**Figure 9:** Carte de l'ACP](../figures_rmarkdown/figure9_CARTE_acp.png)
Éléments de la carte : 

- **Couleur** (pour la variable relative) pour le pourcentage d'urbanisation
- **Taille** (pour la variable absolue) pour le nombre total d'habitants par commune 


#### 3.4 Discussion des résultats et perspectives

La première dimension est fortement représentée par trois variables : La proportion des surfaces industrielles et commerciales par commune (en hectares) par rapport à la surface totale de la commune (SURFIND), la proportion de la surface des bâtiments résidentiels (ha) par rapport à la surface totale de la commune (ha) (SURFHAB) et la proportion des emplois dans le secteur primaire par rapport au nombre total d'emplois dans la commune (EPT1) : Ces deux variables sont caractéristiques des communes rurales. 

En effet, il semble logique de trouver dans les zones rurales une plus petite proportion de bâtiments, d'industries et de surfaces commerciales que dans les zones urbaines, respectivement une plus grande proportion d'emplois dans le premier secteur économique.
Les communes ayant un score factoriel faible ont donc une caractéristique plutôt rurale, contrairement aux communes ayant un score factoriel élevé, qui sont alors plutôt classées comme urbaines. La carte illustre ce phénomène sur le plan spatial. 
On peut constater que la partie sud-est (Communes autour de Reinach) et nord-ouest (communes autour de Kölliken et Schöftland) sont plus urbanisées que les autres, car c'est là que se concentrent les principales activités industrielles de la région et que l'on trouve les valeurs les plus élevées de logements (SURFHAB) et de surfaces de transport (SURFIND). En regardant le diagramme à barres montrant la contribution de chaque indicateur à la première composante, on peut voir que la contribution de la variable RESSEC n'est pas fort, raison pourquoi elle n'est pas intègré dans le raisonnement de cette interprétation. 

Comme une carte en symboles proportionnels a été choisie pour cette étude, une constatation intéressante peut en être tirée. En effet, plus les symboles (cercles) sont grands, plus les cercles sont urbains, c'est-à-dire que leur score factoriel est plus élevé. Et donc plus la population dans une commune donnée est grand (en nombre absolue), plus leur score factoriel est élevé et indiquant donc d'une urbanité. Il existe bien sûr certaines exceptions locales (comme par exemple Moosleerau, qui a un score factoriel plus élevé que Kirchleerau, mais dont le cercle est plus petit).

La même analyse peut être effectuée pour les autres dimensions que l'on a décidé de conserver. Dans ce cas, les dimensions suivantes n'ont pas de valeurs de variance expliquée suffisamment élevées pour permettre une interprétation claire des composantes.


### 4. Classification ascendante hierarchique (CAH)

Le clustering est une méthode statistique qui a comme but de grouper un ensemble d'individu ensemble de sorte que les individus dans le même groupe se ressemblent plus que les individus en dehors du groupe (Kaiser, 2022) Parmi les méthodes de clustering les plus connus il y a la classification ascendante hiérarchique(CAH), qui construit une hiérarchie de groupes. Au début, tous les individus sont à part, et petit à petit, les individus qui se ressemblent le plus sont groupés ensemble. En effet, l'algorithme commence par considérer chaque objet comme un **groupe distinct**, puis il combine progressivement les groupes les plus similaires en utilisant une mesure de distance ou de similitude. Dans le cas de cet étude territorial, la distance euclidienne a été utilisé pour mesurer la distance entre deux points dans un espace.  **Ainsi, un arbre de classification, le dendrogramme est construit.**
Le dendrogramme permet d'inspecter visuellement la structure du jeu de données et déterminer le nombre de groupes idéal.


#### 4.1 Explication de la procedure du calcul

La procédure de facturation est expliquée dans le _Notebook_technique_ parallèle.  

#### 4.2 Procédure de sélection des variables

Comme l'ACP de la deuxième étape est suivi de l'ACH de la troisième étape, les données utilisées pour l'établissement de l'ACH sont les mêmes que celles utilisées pour l'ACP. Concrètement et pour rappel, il s'agirait de : 

- (1) _SAU_ : Proportion [%] de la **surface agricole utile** (en hectar) par rapport à la surface totale de la commune (en hectar) -> _Source des données: Office fédéral de la statistique (Swisstopo), Relevé des structures agricoles STRU (2021)_
- (2) _EPT1_ : Proportion [%] des **emplois du secteur primaire** par rapport au total des emplois dans la commune
- (3) _SURFHAB_ : Proportion [%] de la **surface des batiments d'habitat** (ha) par rapport au total de la surface de la commune (ha) -> _Source des données: Office fédéral de la statistique (Swisstopo), Statistique suisse de la superficie (AREA) (2013/18)_
- (4) _RESSEC_ : Proportion [%] des **résidents secondaires** par rapport à tout les types des batiments dans la commune _Source des données: Office fédéral de la statistique (Swisstopo), Dénombrement des logements vacants (2022)_
- (5) _SURFIND_ : Proportion [%] des **surfaces industrielles et commerciales** par commune (en hectares) par rapport à la surface totale de la commune (en hectares) -> _Source des données: Office fédéral de la statistique (Swisstopo), Statistique suisse de la superficie (AREA) (2013/18)_
- (6) _RETR_: Proportion [%] des résidents qui sont agés +65 _-> Sources des données: Statistique de la population et des ménages STATPOP (2021)_
- (7) _ADO_: Proportion [%] des résidents qui sont entre 10 et 19 ans _--> Sources des données: Statistique de la population et des ménages STATPOP (2021)_
- (8) _IP_270920_: Proportion [%] de OUI pour l'initiative populaire "Pour une migration moderée" _-> Sources des données: Swisstopo, Statistique des votations et des élections (2020)_
- (9) _IP_250916_: Proportion [%] de OUI pour l'initiative populaire "AVSplus: Pour une AVS forte" _-> Sources des données: Swisstopo, Statistique des votations et des élections (2016)_
- (10) _IP_291120_: Proportion [%] de OUI pour l'initiative populaire «Entreprises responsables – pour protéger l'être humain et l'environnement» _-> Sources des données: Swisstopo, Statistique des votations et des élections (2020)_
- (11) _IP_130222_: Proportion [%] de OUI pour l'initiative populaire «Oui à l'interdiction de l'expérimentation animale et humaine" _-> Sources des données: Swisstopo, Statistique des votations et des élections (2022)_

#### 4.3 Résultats 

##### 4.3.1 Dendogramme

Le dendogramme généré est présenté ci-dessous. Le dendogramme contient 25 points de départ (partie inférieure du dendogramme) qui représentent les communes. Visuellement, à l'œil nu, il est possible d'identifier 4 groupes principaux de communes les plus similaires. En augmenant la distance, ils se réduisent à 2 grands groupes. 

![**Figure 10:**Dendogramme](../figures_rmarkdown/figure10_dendogramme.png)

##### 4.3.2 Boxplots 

Pour chaque variable, des boxplots ont été réalisés afin d'étudier les différences et similarités entre les clusters. Cela facilitera grandement l'analyse dans le chapitre **[4.4 Résultats]**.

Voici les Boxplots qui ont étaient crées pour chaque variable en fonction des clusters: 
![**Figure 11:**Boxplots](../figures_rmarkdown/figure12.png)


##### 4.3.3 Carte des clusters 

Egalement, afin de pouvoir mieux interpréter les résultats de la CAH par la suite, une carte des clusters est créée. 

Création de la carte : Les données exportées par le _notebook_technique_ ont été exportées sous forme de fichier .csv, traitées dans excel et ont ainsi pu être chargées dans le programme QGis. Un lien a ensuite été créé entre les communes (shape-file de Swisstopo, 2021) et le tableau Excel. Il a été possible de vérifier si cette liaison était réussie dans le tableau d'attribution des communes, où le numéro de classe devait être listé dans la dernière colonne. Après vérification, il est possible de sélectionner sous "Symbology" la graduation dans la classification des pourcentages dans Jenks, après quoi les communes sont réparties en quatre couleurs différentes représentant les différentes classes.

![**Figure 12:**Carte des clusters](../figures_rmarkdown/figure11_CARTE_cah.png)
Éléments de la carte : 

- **Couleur** (pour la variable nominale) pour les différentes classes 

#### 4.4 Discussion des résultats et perspectives

Dans le texte suivant, les différents clusters sont comparés entre eux. 


**Caractéristiques et particularités du premier cluster** : Avec une proportion de 2,1% de surfaces industrielles et commerciales (SURFIND) ainsi qu'une proportion de 22% de surfaces de bâtiments (SURFHAB), ces médianes sont nettement plus élevées par rapport à celles des autres clusters. En partant de l'hypothèse que la part de ces surfaces par rapport à la superficie totale de la commune est plus élevée dans les zones urbaines que dans les zones plus rurales, on peut supposer que les communes urbaines ont été regroupées dans ce premier cluster. Un autre indice qui renforce cette réflexion est que la médiane de la part des emplois dans le secteur primaire (EPT1) est la plus faible (3%) par rapport à la médiane des autres clusters. Cela signifie donc en même temps que la part des deuxième et troisième secteurs économiques doit être d'autant plus élevée, ce qui semble logique si l'on considère l'hypothèse selon laquelle les emplois sont plus nombreux dans les zones où les surfaces industrielles et commerciales et les surfaces de bâtiments sont plus importantes. De même, la médiane pour les surfaces agricoles utiles (SAU) est nettement plus faible dans le cluster 1 (28%) que pour les autres clusters, ce qui plaide en faveur d'une zone urbanisée. 
En ce qui concerne la répartition spatiale de ce cluster, on peut constater sur la carte chloroplète que les communes urbaines se trouvent à la périphérie de la région du Wynental. D'une part, il y a une concentration de communes urbaines au nord de la région, qui jouxte la ville d'Aarau, et d'autre part, il y a une concentration de communes urbaines au sud de la région, autour de la ville de Reinach. 

**Caractéristiques et particularités des deuxième et troisième clusters** : Pour les clusters 2 et 3, l'analyse des valeurs des boxplots était moins claire. En effet, les médianes entre ces deux clusters étaient similaires pour certaines variables. En revanche, la différence de la médiane concernant la proportion d'emplois dans le secteur économique primaire (EPT1) était significative. Cette valeur est plus élevée dans le cluster 2, avec une médiane de 17%, que dans le cluster 3, qui a une médiane de 9%. La médiane de la part des surfaces agricoles utiles (SAU) est également plus élevée dans le cluster 2 (65%) que la médiane du cluster 3 (45%), ce qui indique que la commune a un caractère plus rural par rapport au troisième cluster. Les deux clusters ont des médianes pour la plupart des variables sélectionnées qui se situent entre les valeurs extrêmes (valeurs marginales) du premier (cluster urbain) et du quatrième cluster (cluster rural), ce qui indique que les communes de ces deux clusters possèdent à la fois les caractéristiques d'un paysage rural et d'un paysage urbain, et que la catégorisation en urbain ou rural est donc moins claire que pour les clusters 1 ou 4. Les valeurs de l'EPT1 et de la SAU sont en revanche très significatives du fait que le deuxième cluster regroupe des communes qui tendent plutôt vers un paysage rural, tandis que le troisième cluster regroupe des communes qui sont plus urbaines. 
Si l'on considère la répartition des communes du deuxième et du troisième cluster, on remarque que les communes du deuxième cluster (communes à caractère rural) se trouvent sur les chaînes de collines, tandis que les communes à caractère urbain se trouvent dans les vallées du Wynental et du Suhrental, qui sont plus facilement constructibles et également mieux desservies par la traversée du Wynentalerbahn. 

**Propriétés et particularités du quatrième cluster** : Le cluster 4, qui ne contient que la valeur d'une commune, à savoir la commune de Williberg, possède une part particulièrement élevée d'emplois dans le secteur économique primaire (EPT1) par rapport aux autres clusters, à savoir 50%. Inversement, cela signifie aussi que les deuxième et troisième secteurs économiques doivent être moins représentés que dans les clusters précédents. Avec 4% de bâtiments (SURFHAB) et 0% d'industrie et de surfaces commerciales (SURFIND), ces structures sont nettement moins représentées dans les communes de ce cluster que dans les clusters précédents, déjà mentionnés. Avec une part de 50%, les surfaces agricoles de la commune de Wiliberg, qui représente le quatrième cluster, sont nettement plus élevées que les médianes des autres clusters. Ces valeurs soutiennent l'hypothèse selon laquelle le cluster 4 regroupe des communes qui sont rurales. Effectivement, cette hypothèse est soutenue par la typologie de l'OFS qui affiche une typologie "rurale" pour la commune Wiliberg qui compose ce cluster.  


Nom des quatres clusters:

- Cluster 1 : Région urbaine
- Cluster 2 : Région à caractère rurale  
- Cluster 3 : Région à caractère urbaine
- Cluster 4 : Région rurale

Remarque : Les autres variables sélectionnées (élections politiques, proportion de la population d'adolescentes et retraitée et proportion des résidences secondaires) n'ont pas été prises en compte dans l'interprétation des catégorisations des clusters, car les valeurs variaient considérablement d'un cluster à l'autre et ne fournissaient donc pas d'informations claires. De même, la proportion des votes OUI lors des élections politiques dépend du thème de l'élection et il faudrait faire une analyse plus approfondie des différents votes pour voir quelles orientations politiques représentent les différentes communes.  

### 5. Conclusion
Les interprétations des différents résultats statistiques ont permis de mieux comprendre les thématiques spatiales spécifiques à la région du Wynental. En particulier pour les résultats de l'ACP et de l'ACH, une analyse plus approfondie des résultats individuels serait, selon les circonstances, indispensable pour mieux appréhender l'ensemble des variables et les relations entre elles. Les facteurs pourraient être interprétés par un expert en la matière afin d'identifier une tendance, une caractéristique ou un thème qui regroupe et unit les individus, dans notre analyse régionale, les communes. Cependant, les résultats et les interprétations trouvés sont tout à fait suffisants pour cette étude. 

### 6. Bibliographie 

- Analyse-R (2019). La régression logistique. Repéré à https://larmarange.github.io/analyse-R/regression-logistique.html
- De-academic (2020). Konfusionsmatrix. Repéré à https://de-academic.com/dic.nsf/dewiki/787468
- Jedha (2021). Matrice de confusion. Comment la lire et l'intérpreter? Repéré à https://www.jedha.co/formation-ia/matrice-confusion
- Kaiser (2022)
- OpenEdition (2020). L’intérêt de l’analyse en composantes principales (ACP) pour la recherche en sciences sociales. Repéré à https://journals.openedition.org/cal/7364
- Studiflix (2021). Faktorenanalyse. Repéré à https://studyflix.de/statistik/faktorenanalyse-2210
- Swisstopo (2021). Typologie des communes avec 3 catégories 2012. Repéré à https://www.bfs.admin.ch/asset/fr/2543283 
- Wikipedia (2022). Landwirtschaftlich genutzte Flächen. Repéré à https://de.wikipedia.org/wiki/Landwirtschaftlich_genutzte_Fläche
