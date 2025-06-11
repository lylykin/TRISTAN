import 'package:flutter/material.dart';
import 'dart:math';

class LeSaviezVous extends StatelessWidget {
  final String? materialId;
  const LeSaviezVous({super.key, this.materialId});

  @override
  Widget build(BuildContext context) {
    Map<String, List<String>> facts = {
      "pet": [
        "Le saviez-vous ?\nLe PET est entièrement recyclable, presque infiniment ! ",
        "Le saviez-vous ?\nLe PET est l’un des matériaux d’emballage plastique les plus utilisés au monde !",
        "Le saviez-vous ?\n1,5 million d'animaux sont tués par le plastique chaque année",
        "Conseils:\nPensez à bien vider les bouteilles et flacons.\n Ne pas laver les emballages, Écraser les bouteilles dans le sens de la hauteur.\n Pensez à visser les bouchons sur les bouteilles pour qu’ils soient recyclés ou bien gardez les pour l’association BOUCHONS d’AMOUR : ",
      ],
      "hdpe": [
        "Le saviez-vous?\nLe HDPE est l’un des plastiques les plus résistants!",
      ],
      "pvc": [
        "Le saviez-vous ?\nLe PVC est composé de : 57 % de sel de mer + 43 % de dérivés du pétrole",
        "Le saviez-vous ?\nLe PVC a été découvert par accident en 1835 par Henri Victor Regnault, un physicien français",
        "Le saviez-vous ?\nPlus de 50 % de la production annuelle de PVC en France est consommée par le secteur du BTP",
        " Le saviez-vous ?\nL’industrie du PVC en Europe s’est engagée à recycler 900 000 tonnes de plastiques de PVC d’ici 2025 au travers du plan VinylPlus. Au début des années 2000, ce matériau n’était même pas considéré comme un plastique recyclable et présentait un vrai danger pour l’environnement…",
      ],
      "pap": [
        "Le saviez-vous ?\nLe papier ne se recycle pas indéfiniment. En théorie, le papier peut être réutilisé 9 fois",
        " Le saviez-vous ?\n70 à 85 kilos par an et par salarié : c’est la consommation annuelle de papier estimée par l’ADEME.",
        "Le saviez-vous ?\nSeulement 60 % des papiers sont recyclés en France",
        "Conseils:\nPensez à retirer les films plastiques autour des revues.\n Ne déchirez pas les feuilles en petits morceaux et évitez de les froisser.",
      ],
      "pp": [
        "Le saviez-vous ?\nLe polypropylène résiste à des températures pouvant aller jusqu’à 100°C!!!",
      ],
      "ps": [
        "Le saviez-vous ?\nLe principal obstacle à la collecte reste le caractère diffus et très fin du polystyrène, que l’on trouve sous forme d’une barquette d’emballage alimentaire par exemple. Le taux de recyclage est estimé à 30 %, alors que le matériau est 100 % valorisable...",
        "Le saviez-vous ?\nLe polystyrène expansé (PSE), le plus courant en France, est composé à 98 % de gaz et 2 % de matière valorisable.",
      ],
      "fe": [
        "Le saviez-vous ?\nEn 2018, plus de 12 millions de tonnes de matières premières ferreuses (fer, fonte, et acier) ont été produites par les entreprises françaises de recyclage, ce qui a permis une économie de 17 Mt de CO2.",
        "Le saviez-vous ?\nDans la nature, le fer ou l’acier mettent jusqu’à plus de 10 ans à rouiller puis disparaître.",
      ],
      "alu": [
        "Le saviez-vous ?\nL’aluminium recyclé permet d’économiser jusqu’à 95 % d’énergie et 70 % d’eau par rapport aux quantités consommées au moment de l’élaboration de l’aluminium primaire par le procédé d’électrolyse.",
        " Le saviez-vous ?\n660 canettes en aluminium recyclées permettent de fabriquer un vélo, 48.000 une voiture et 15 millions un avion A380 d’Airbus !",
        " Le saviez-vous ?\nLe recyclage d’un contenant en aluminium se fait sur un cycle très court. En revanche, jetées dans la nature, les canettes d’aluminium mettent environ 500 ans avant de se dégrader.",
      ],
      "gl": [
        "Le saviez-vous ?\n1 tonne de verre recyclée = 1 tonne de verre reconstituée = 0,46 tonne eq. CO2 économisée ",
        "Le saviez-vous ?\n77,9% du verre a été recyclé en France en 2017 selon l’ADEME, soit plus de 3 bouteilles sur 4.",
      ],
      "ldpe": [
        "Le saviez-vous ?\nDepuis le 1er janvier 2017, la loi relative à la transition énergétique pour la croissance verte a imposé l’interdiction des sacs plastiques aux caisses des commerces en France",
      ],
      "carton": [
        "Le saviez-vous ?\nLa production annuelle de déchets cartons de la grande distribution en France est de 1 million de tonnes. ",
        "Conseils: Inutile de laver les briques alimentaires avant de les déposer dans la colonne jaune. Séparez les emballages carton de leurs suremballages en plastique (barquettes, sachets, films). Les gros cartons d’emballage marron sont à apporter en déchèterie.",
      ],
      "Missing Material Name":[
        "Le saviez-vous ?\nIl arrive des erreurs même aux meilleurs.\nNotre équipe a un matériau non pris en charge pour les fun facts dans la base de donnée, merci de votre compréhension.",
      ],
      "acier":[
        "Le saviez-vous ?\nPour fabriquer de l’acier, il faut du minerai du fer, du charbon, de la chaux et des ferro-alliages",
        "Le saviez-vous?\nL’acier est recyclable à 100%, c’est même le matériau le plus recyclé au monde !",
        "Le saviez-vous?\nUne tonne d’acier recyclé permet d’économiser 1,5 tonnes de minerai de fer, 0,65 tonne de charbon et 0,3 tonne de chaux.\nUne tonne d’acier recyclée permet d’économiser 70 % d’énergie.\nUne tonne d’acier recyclée permet d’économiser 1,5 tonne de CO2.\n80 à 90 % de l’acier produit est toujours utilisé à ce jour.",
      ],
      "empty":[
        "N'oubliez pas de mettre un objet dans la boite !",
        "Tristan n'a rien detecté, êtes vous sûr d'avoir ajouté un objet?",
      ],
      "bois":[
        "Le bois n'est pas récupéré dans les poubelles de tri. Veuillez l'amener dans une dechetterie!!\n Le saviez-vous?\n En France, selon l’ADEME, ce sont plus de 7,2 millions de tonnes de déchets de bois qui sont produits tous les ans.\n Sur ces 7,2 millions, 28 % sont utilisés pour la valorisation énergétique et 61 % sont recyclés pour fabriquer de nouveaux produits",
      ],
      "pes":[
        "Le saviez-vous?\nLe polyester sèche plus vite que le coton.",
        "Le saviez-vous?\nIl peut être 100 % recyclé !\nMais il peut mettre plus de 200 ans à se décomposer dans la nature...\n D’où l’intérêt de le recycler!",
      ]
    };
    String? displayInfoText;
    if (facts[materialId]?.isNotEmpty ?? false) { // Si le matériau est reconnu (donc bool non null) et que il existe des conseils associés
      displayInfoText = facts[materialId]![Random().nextInt(facts[materialId]!.length)]; // Définit le texte aléatoirement selon le matériau
    } else {
      displayInfoText = facts["Missing Material Name"]![Random().nextInt(facts["Missing Material Name"]!.length)]; // A défaut, prendre la liste erreur (supposée non vide)
    }

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
