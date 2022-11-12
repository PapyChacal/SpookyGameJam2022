class_name element

# IGNORER : Pas d'objet pour le moment
# Dico objet -> dialogue déclenché
# Si absent, fallback sur description par défaut
var objet_utilisable : Dictionary


# Marqueur personne (=> coûte 1 énergie)
var personne : bool
# Dialogue d'interaction
var interaction : String

func _init(inter : String, objets : Dictionary, pers : bool = false):
	objet_utilisable = objets
	personne = pers
	interaction = inter
