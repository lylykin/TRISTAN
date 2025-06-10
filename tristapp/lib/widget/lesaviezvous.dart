import 'package:flutter/material.dart';
import 'dart:math';

class LeSaviezVous extends StatelessWidget {
  final String? materialId;
  const LeSaviezVous({super.key, this.materialId});

  @override
  Widget build(BuildContext context) {
    Map<String, List<String>> facts = {
      "pet": [
        "Le saviez-vous ?\n Le PET est entièrement recyclable, presque infiniment ! ",
        "Le saviez-vous ?\n Le PET est l’un des matériaux d’emballage plastique les plus utilisés au monde !",
        "Le saviez-vous ?\n 1,5 million d'animaux sont tués par le plastique chaque année",
        "Conseils:\n Pensez à bien vider les bouteilles et flacons.\n Ne pas laver les emballages, Écraser les bouteilles dans le sens de la hauteur.\n Pensez à visser les bouchons sur les bouteilles pour qu’ils soient recyclés ou bien gardez les pour l’association BOUCHONS d’AMOUR : ",
      ],
      "hdpe": [],
      "pvc": [
        "Le saviez-vous ?\n Le PVC est composé de : 57 % de sel de mer + 43 % de dérivés du pétrole",
        "Le saviez-vous ?\n  Le PVC a été découvert par accident en 1835 par Henri Victor Regnault, un physicien français",
        "Le saviez-vous ?\n Plus de 50 % de la production annuelle de PVC en France est consommée par le secteur du BTP",
        " Le saviez-vous ?\n L’industrie du PVC en Europe s’est engagée à recycler 900 000 tonnes de plastiques de PVC d’ici 2025 au travers du plan VinylPlus. Au début des années 2000, ce matériau n’était même pas considéré comme un plastique recyclable et présentait un vrai danger pour l’environnement…",
      ],
      "pap": [
        "Le saviez-vous ?\n Le papier ne se recycle pas indéfiniment. En théorie, le papier peut être réutilisé 9 fois",
        " Le saviez-vous ?\n 70 à 85 kilos par an et par salarié : c’est la consommation annuelle de papier estimée par l’ADEME.",
        "Le saviez-vous ?\n Seulement 60 % des papiers sont recyclés en France",
        "Conseils:\n Pensez à retirer les films plastiques autour des revues.\n Ne déchirez pas les feuilles en petits morceaux et évitez de les froisser.",
      ],
      "pp": [
        "Le saviez-vous ?\n Le polypropylène résiste à des températures pouvant aller jusqu’à 100°C!!!",
      ],
      "ps": [
        "Le saviez-vous ?\n Le principal obstacle à la collecte reste le caractère diffus et très fin du polystyrène, que l’on trouve sous forme d’une barquette d’emballage alimentaire par exemple. Le taux de recyclage est estimé à 30 %, alors que le matériau est 100 % valorisable...",
        "Le saviez-vous ?\n  Le polystyrène expansé (PSE), le plus courant en France, est composé à 98 % de gaz et 2 % de matière valorisable.",
      ],
      "fe": [
        "Le saviez-vous ?\n En 2018, plus de 12 millions de tonnes de matières premières ferreuses (fer, fonte, et acier) ont été produites par les entreprises françaises de recyclage, ce qui a permis une économie de 17 Mt de CO2.",
        "Le saviez-vous ?\n Dans la nature, le fer ou l’acier mettent jusqu’à plus de 10 ans à rouiller puis disparaître.",
      ],
      "alu": [
        "Le saviez-vous ?\n L’aluminium recyclé permet d’économiser jusqu’à 95 % d’énergie et 70 % d’eau par rapport aux quantités consommées au moment de l’élaboration de l’aluminium primaire par le procédé d’électrolyse.",
        " Le saviez-vous ?\n 660 canettes en aluminium recyclées permettent de fabriquer un vélo, 48.000 une voiture et 15 millions un avion A380 d’Airbus !",
        " Le saviez-vous ?\n Le recyclage d’un contenant en aluminium se fait sur un cycle très court. En revanche, jetées dans la nature, les canettes d’aluminium mettent environ 500 ans avant de se dégrader.",
      ],
      "gl": [
        "Le saviez-vous ?\n 1 tonne de verre recyclée = 1 tonne de verre reconstituée = 0,46 tonne eq. CO2 économisée ",
        "Le saviez-vous ?\n 77,9% du verre a été recyclé en France en 2017 selon l’ADEME, soit plus de 3 bouteilles sur 4.",
      ],
      "ldpe": [
        "Le saviez-vous ?\n Depuis le 1er janvier 2017, la loi relative à la transition énergétique pour la croissance verte a imposé l’interdiction des sacs plastiques aux caisses des commerces en France",
      ],
      "carton": [
        "Le saviez-vous ?\n La production annuelle de déchets cartons de la grande distribution en France est de 1 million de tonnes. ",
        "Conseils: Inutile de laver les briques alimentaires avant de les déposer dans la colonne jaune. Séparez les emballages carton de leurs suremballages en plastique (barquettes, sachets, films). Les gros cartons d’emballage marron sont à apporter en déchèterie.",
      ],
      "Missing Material Name":[
        "Le saviez-vous ?\n Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam semper turpis enim, sit amet dapibus ex consectetur vitae. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur at urna feugiat, interdum lorem vitae, imperdiet dui. Nullam vulputate eros eu sem molestie, in pellentesque lorem scelerisque. Aenean dui tellus, sodales ut sem vitae, vestibulum tincidunt urna. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec laoreet ultricies lorem quis aliquam. Sed sit amet nunc et magna lobortis vestibulum vel pellentesque ipsum. Suspendisse consequat volutpat lacinia. Pellentesque hendrerit ultrices laoreet. Duis et eleifend augue. Donec fermentum nunc id lectus sagittis, ut rutrum dui facilisis. Phasellus eleifend venenatis felis, id semper quam iaculis vel.",
      ],
    };
    String? displayInfoText = facts[materialId]?[Random().nextInt(facts[materialId]!.length)] // Définit le texte aléatoirement selon le matériau
      ?? facts["Missing Material Name"]![Random().nextInt(facts["Missing Material Name"]!.length)]; // Si le matériau n'est pas reconnu (résultat null) alors prendre dans la liste erreur
    return SizedBox(
      width: 300,
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ), //DefaultTextStyle.of(context).style, // hérite du style global
          children: [
            TextSpan(
              text: displayInfoText,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Theme.of(context).colorScheme.primary,
                backgroundColor: Theme.of(context).colorScheme.surface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
