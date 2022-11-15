extends ValidateButton
class_name ChoiceButton

func set_reponse(r : reponse):
		$VBox/Text.text = r.text
		$VBox/Text.percent_visible = 0.0
		$Energy.visible = GameState.reponse_cost_energy(r)

