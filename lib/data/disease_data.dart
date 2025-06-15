import 'package:plant_doctor/models/plant_disease.dart';

class DiseaseDataParser {
  static List<PlantDisease> getInitialDiseaseData() {
    return [
      // Apple Diseases
      PlantDisease(
        id: 'apple_apple_scab', // <-- update this line to match MLService _getDiseaseId('Apple___Apple_scab')
        name: 'Apple Scab',
        scientificName: 'Venturia inaequalis',
        crop: 'Apple',
        pathogenType: 'Fungus',
        description: 'Apple scab is caused by the fungus Venturia inaequalis. This pathogen primarily affects members of the rose family, including apples and ornamental crabapples. The pathogen\'s ability to infect a broad range of hosts within the rose family means that managing apple scab cannot be isolated to just apple orchards.',
        symptoms: [
          'Small, velvety brown to olive green spots with feathery, indistinct margins',
          'Lesions enlarge and darken to become circular',
          'On older leaves, lesions are typically raised, dark green to gray-brown with distinct margins',
          'Heavily infected young leaves curl and distort',
          'On fruit, small black spots develop, enlarging more slowly than on leaves',
          'Fruit lesions become corky, cracked, and rough'
        ],
        diseasecycle: 'The fungus overwinters as fungal spores (pseudothecia containing ascospores) in diseased leaves on the orchard floor. The first fungal spores mature and are capable of causing infections in spring around the time of budbreak. Once established, the fungus produces secondary spores (conidia) that re-infect new leaves throughout the summer.',
        environmentalConditions: 'Apple scab is most severe during spring and early summer when humidity is high and temperature is moderate. Infection depends on rainfall and temperature; fewer hours of wet leaf surfaces are required at high temperatures than at low ones.',
        culturalManagement: [
          'Collecting and removing diseased leaves and twigs in the fall or winter before bud break',
          'Pruning for good air circulation',
          'Planting resistant apple and crabapple varieties'
        ],
        chemicalManagement: [
          'Apply fungicides when conditions for infection are imminent',
          'Programs typically begin between silver tip and green tip stages',
          'Continue at 7-10 day intervals, with shorter intervals during frequent heavy rainfall',
          'From first cover until early August, applications should be at 10–14-day intervals'
        ],
        resistantVarieties: [
          'Liberty',
          'Enterprise',
          'Freedom',
          'Pristine'
        ],
      ),

      PlantDisease(
        id: 'apple_black_rot',
        name: 'Apple Black Rot',
        scientificName: 'Botryosphaeria obtusa',
        crop: 'Apple',
        pathogenType: 'Fungus',
        description: 'Black rot, also known as frog-eye leaf spot, is caused by the fungus Botryosphaeria obtusa. This pathogen has the capacity to infect all parts of the apple and pear tree, including fruits, leaves, branches, and trunks.',
        symptoms: [
          'Small purple flecks on leaves that enlarge to 4-5mm with purple margin and tan or brown center',
          'Distinctive "frog-eye" appearance on leaves',
          'Sunken spots (cankers) on woody tissues with enlarged margins',
          'Brown rotting on fruit beginning at blossom end',
          'Infected fruit eventually turns coal black and may mummify'
        ],
        diseasecycle: 'The fungus overwinters in cankers on limbs, branches, and trunks, as well as in mummified fruit left on the tree or on the orchard floor. Spores are released early in the season, around bud swell, and continue to be released throughout the growing season.',
        environmentalConditions: 'The disease prefers relatively high temperatures, with activity beginning above 48°F. The optimum temperature for disease development is approximately 78-80°F. Leaf infection requires only four hours of wetting at optimum temperatures.',
        culturalManagement: [
          'Removing mummified fruit, dead trees, and dead or dying infected limbs',
          'Pruning out cankers significantly reduces available inoculum',
          'Cultivating the vineyard before bud break to bury mummified berries'
        ],
        chemicalManagement: [
          'Apply full-rate protectant sprays early in the season using copper-based products',
          'Ethylene bisdithiocarbamate (EBDC) fungicides such as Polyram, Manzate, and Dithane',
          'After petal fall, Captan at full rate or combination of Benlate and Captan'
        ],
        resistantVarieties: [
          'Most commercial cultivars are sufficiently resistant if adequately protected'
        ],
      ),

      PlantDisease(
        id: 'apple_cedar_apple_rust', // updated to match MLService
        name: 'Apple Cedar Apple Rust',
        scientificName: 'Gymnosporangium juniperi-virginianae',
        crop: 'Apple',
        pathogenType: 'Fungus',
        description: 'Cedar apple rust is caused by the fungal pathogen Gymnosporangium juniperi-virginianae. This fungus requires two different hosts to complete its life cycle: crabapples and apples (Malus sp.), and eastern red cedar (Juniperus virginiana).',
        symptoms: [
          'Small galls on juniper needles and twigs that produce orange, gelatinous telial horns',
          'Tiny yellow-greenish spots on apple leaves that enlarge to become orange-yellow with red border',
          'Black fruiting structures (spermogonia) visible on upper leaf surface',
          'Cup-like structures (aecia) on undersides of mature leaf lesions',
          'Yellow lesions on fruits that are usually larger than those on leaves'
        ],
        diseasecycle: 'The pathogen requires both juniper and apple hosts to complete its complex life cycle. Spores from juniper galls infect apple leaves in spring, and spores from apple infections later infect juniper hosts.',
        environmentalConditions: 'Disease development is favored by wet spring weather when spores are released from juniper galls and infect apple foliage.',
        culturalManagement: [
          'Remove nearby eastern red cedar and juniper plants within a few hundred yards',
          'Plant resistant apple varieties',
          'Improve air circulation through proper pruning'
        ],
        chemicalManagement: [
          'Apply fungicides during spore release periods in spring',
          'Protective sprays during wet weather when spores are being released',
          'Multiple applications may be needed during extended wet periods'
        ],
        resistantVarieties: [
          'Liberty',
          'Enterprise',
          'Freedom',
          'Redfree'
        ],
      ),

      // Cherry Diseases
      PlantDisease(
        id: 'cherry_powdery_mildew',
        name: 'Cherry Powdery Mildew',
        scientificName: 'Podosphaera clandestina',
        crop: 'Cherry',
        pathogenType: 'Fungus',
        description: 'Powdery mildew of cherry is caused by the fungus Podosphaera clandestina. This disease affects both sweet and sour cherries, causing white powdery growth on leaves and shoots.',
        symptoms: [
          'White powdery fungal growth on upper and lower leaf surfaces',
          'Leaves may curl, distort, and become stunted',
          'Infected shoots may be stunted with shortened internodes',
          'Fruit infections can occur but are less common'
        ],
        diseasecycle: 'The fungus overwinters in dormant buds and on bark. In spring, spores are produced and spread by wind to infect new growth.',
        environmentalConditions: 'Disease development is favored by moderate temperatures (60-80°F) and high humidity, but does not require free moisture.',
        culturalManagement: [
          'Plant resistant varieties',
          'Prune for good air circulation',
          'Remove water sprouts and suckers',
          'Avoid excessive nitrogen fertilization'
        ],
        chemicalManagement: [
          'Apply fungicides preventively starting at bud break',
          'Sulfur-based fungicides are effective',
          'Sterol inhibiting fungicides provide good control',
          'Multiple applications may be needed throughout the season'
        ],
        resistantVarieties: [
          'Some sweet cherry varieties show moderate resistance'
        ],
      ),

      // Corn Diseases
      PlantDisease(
        id: 'corn_gray_leaf_spot',
        name: 'Corn Gray Leaf Spot',
        scientificName: 'Cercospora zeae-maydis',
        crop: 'Corn',
        pathogenType: 'Fungus',
        description: 'Gray leaf spot is caused by the fungus Cercospora zeae-maydis. This disease is widely recognized as the most significant yield-limiting disease of corn globally.',
        symptoms: [
          'Small, tan, rectangular spots on lower leaves first',
          'Mature lesions are long (up to 2 inches), narrow, rectangular, and light tan',
          'Lesions later turn gray and are usually delimited by leaf veins',
          'Can coalesce forming large necrotic areas and potentially killing entire leaves'
        ],
        diseasecycle: 'The fungus survives in corn residue remaining on the soil surface. In late spring, following periods of high humidity, the fungus produces spores within this residue that are wind-dispersed to newly planted corn.',
        environmentalConditions: 'Infection and disease development are favored by warm temperatures (in the 80s°F) and high humidity (greater than 90% for 12 or more hours).',
        culturalManagement: [
          'Use resistant corn hybrids and inbreds',
          'Rotate with non-host crops',
          'Tillage practices to promote decomposition of infected corn residue',
          'Disk or plow fields immediately after harvest'
        ],
        chemicalManagement: [
          'Foliar fungicides specifically labeled for gray leaf spot',
          'Applications may be considered in high disease risk years',
          'Particularly important when susceptible hybrids are planted in no-till fields'
        ],
        resistantVarieties: [
          'Numerous hybrids offer resistance, although none are completely immune'
        ],
      ),

      PlantDisease(
        id: 'corn_maize_common_rust_', // <-- update this line
        name: 'Corn Common Rust',
        scientificName: 'Puccinia sorghi',
        crop: 'Corn',
        pathogenType: 'Fungus',
        description: 'Common rust of corn is caused by the fungus Puccinia sorghi. The fungus does not overwinter in temperate corn-growing regions but survives in subtropical and tropical regions.',
        symptoms: [
          'Early symptoms appear as chlorotic flecks on leaf surface',
          'Powdery, brick-red pustules develop as spores break through leaf surface',
          'Pustules are typically oval or elongated, approximately 1/8 inch long',
          'Leaf tissue surrounding pustules may turn yellow or die',
          'As pustules age, spores turn black making pustules appear dark'
        ],
        diseasecycle: 'The fungus does not overwinter in temperate regions. Spores are carried long distances by wind currents from subtropical regions, reaching the Midwest and initiating new infections each growing season.',
        environmentalConditions: 'Rust development is favored by high humidity, night temperatures of 65-70°F, and moderate daytime temperatures.',
        culturalManagement: [
          'Plant resistant corn hybrids and inbreds',
          'Local sanitation has little impact due to migratory nature of pathogen'
        ],
        chemicalManagement: [
          'Foliar fungicides specifically labeled for common rust',
          'Applications typically considered after disease arrival in the region'
        ],
        resistantVarieties: [
          'Resistant corn hybrids and inbreds are available'
        ],
      ),

      PlantDisease(
        id: 'corn_northern_leaf_blight',
        name: 'Northern Corn Leaf Blight',
        scientificName: 'Exserohilum turcicum',
        crop: 'Corn',
        pathogenType: 'Fungus',
        description: 'Northern corn leaf blight (NCLB) is caused by the fungus Exserohilum turcicum. Several races of this pathogen are known, and they interact differently with various resistance genes in corn hybrids.',
        symptoms: [
          'Distinctive canoe-shaped lesions, ranging from 1 to 6 inches in length',
          'Initially gray-green margins, eventually turn tan',
          'Under high humidity, spores coating lesions can turn olive-green or black',
          'Symptoms typically begin on lower leaves and spread upwards',
          'Can contribute to stalk rot and lodging'
        ],
        diseasecycle: 'The fungus survives the winter on infected corn residue at the soil surface. As temperatures rise in spring and early summer, the fungus produces spores on this residue that are wind-blown onto new corn crop leaves.',
        environmentalConditions: 'Most prevalent during moderate temperatures (65-80°F) combined with precipitation and high humidity. Infection requires leaf surfaces to remain wet for 6-18 hours.',
        culturalManagement: [
          'Select resistant corn hybrids',
          'One-year rotation away from corn followed by tillage',
          'In no-till fields with NCLB history, consider two-year rotation',
          'Practices that encourage residue decomposition'
        ],
        chemicalManagement: [
          'Fungicides can be applied preventively or curatively',
          'Pay attention to weather forecasts indicating potential for disease development',
          'May be warranted on inbreds for seed production'
        ],
        resistantVarieties: [
          'Different hybrids exhibit varying degrees of moderate resistance'
        ],
      ),

      // Tomato Diseases
      PlantDisease(
        id: 'tomato_bacterial_spot',
        name: 'Tomato Bacterial Spot',
        scientificName: 'Xanthomonas vesicatoria complex',
        crop: 'Tomato',
        pathogenType: 'Bacterium',
        description: 'Bacterial spot is caused by several Xanthomonas species including X. vesicatoria, X. euvesicatoria, X. gardneri, and X. perforans. This disease can cause significant yield losses in tomato production.',
        symptoms: [
          'Water-soaked lesions on leaves that rapidly change from green to dark brown',
          'Spots up to 1/4 inch in diameter with slightly raised margins',
          'In less humid weather, spots dry up causing "shothole" appearance',
          'On fruit, raised, scab-like spots render them unmarketable',
          'Elongated, raised, light-brown cankers on stems'
        ],
        diseasecycle: 'The pathogen survives in and on seeds and in plant debris. Bacteria can move within fields via wind-driven rain, irrigation droplets, aerosols, and handling of wet plants.',
        environmentalConditions: 'Disease develops rapidly during warm temperatures and prolonged wet conditions. Favored by relative humidity above 85%, extended leaf wetness, and heat waves with night temperatures above 70°F.',
        culturalManagement: [
          'Use pathogen-free certified seeds and disease-free transplants',
          'Crop rotation avoiding fields previously planted with peppers or tomatoes',
          'Remove debris and manage infested crop debris',
          'Replace overhead irrigation with drip irrigation',
          'Avoid accessing fields when plants are wet'
        ],
        chemicalManagement: [
          'Copper sprays can help control bacterial leaf spot',
          'More effective when combined with plant resistance inducers',
          'Streptomycin for greenhouse transplants (resistance concerns)',
          'Applications every 7-10 days, adjusting for weather conditions'
        ],
        resistantVarieties: [
          'Varieties resistant to multiple strains are available'
        ],
      ),

      PlantDisease(
        id: 'tomato_early_blight',
        name: 'Tomato Early Blight',
        scientificName: 'Alternaria solani',
        crop: 'Tomato',
        pathogenType: 'Fungus',
        description: 'Early blight is a common fungal disease of solanaceous crops caused by Alternaria solani. Despite its name, it typically appears on older plants and leaves.',
        symptoms: [
          'Circular, dark-brown spots on leaves and stems',
          'Distinctive concentric, target-like rings often surrounded by yellow margins',
          'Foliar symptoms usually occur on older leaves first',
          'Dark, slightly sunken, concentric lesions on stems',
          'On fruit, dark, sunken lesions often at stem end'
        ],
        diseasecycle: 'The fungus overwinters in infected plant debris and soil. Spores are produced on debris and spread by wind, rain splash, and irrigation water to infect new plants.',
        environmentalConditions: 'Disease development is favored by warm temperatures (75-85°F), high humidity, and leaf wetness. Stressed plants are more susceptible.',
        culturalManagement: [
          'Crop rotation with non-solanaceous crops',
          'Remove and destroy infected plant debris',
          'Improve air circulation through proper spacing and pruning',
          'Avoid overhead irrigation',
          'Maintain plant vigor through proper nutrition'
        ],
        chemicalManagement: [
          'Preventive fungicide applications starting early in season',
          'Chlorothalonil, mancozeb, and copper-based fungicides',
          'Rotate fungicide classes to prevent resistance',
          'Apply before disease symptoms appear'
        ],
        resistantVarieties: [
          'Some varieties show moderate resistance'
        ],
      ),

      PlantDisease(
        id: 'tomato_late_blight',
        name: 'Tomato Late Blight',
        scientificName: 'Phytophthora infestans',
        crop: 'Tomato',
        pathogenType: 'Oomycete',
        description: 'Late blight is caused by the oomycete Phytophthora infestans, the same pathogen that caused the Irish potato famine. It can rapidly destroy tomato crops under favorable conditions.',
        symptoms: [
          'Water-soaked, irregularly shaped lesions on leaves',
          'Lesions rapidly enlarge and turn brown to black',
          'White, fuzzy sporulation on undersides of leaves during humid conditions',
          'Brown to black lesions on stems and petioles',
          'Firm, brown lesions on green fruit that can cover entire fruit'
        ],
        diseasecycle: 'The pathogen can overwinter in infected potato tubers and plant debris. Spores are produced during cool, wet weather and spread by wind and rain to infect new plants.',
        environmentalConditions: 'Disease development is favored by cool temperatures (60-70°F), high humidity (>90%), and extended periods of leaf wetness.',
        culturalManagement: [
          'Plant certified disease-free transplants',
          'Improve air circulation through proper spacing',
          'Remove and destroy infected plants immediately',
          'Avoid overhead irrigation',
          'Remove volunteer potatoes and tomatoes'
        ],
        chemicalManagement: [
          'Preventive fungicide applications are critical',
          'Copper-based fungicides, chlorothalonil, and mancozeb',
          'Systemic fungicides like metalaxyl for severe outbreaks',
          'Apply before symptoms appear and continue regularly'
        ],
        resistantVarieties: [
          'Some varieties have moderate resistance genes'
        ],
      ),

      // Potato Diseases
      PlantDisease(
        id: 'potato_early_blight',
        name: 'Potato Early Blight',
        scientificName: 'Alternaria solani',
        crop: 'Potato',
        pathogenType: 'Fungus',
        description: 'Early blight of potato is caused by Alternaria solani, the same fungus that affects tomatoes. It primarily affects older plants and can cause significant yield losses.',
        symptoms: [
          'Circular to oval dark brown spots on older leaves',
          'Concentric rings within lesions giving target-like appearance',
          'Yellow halos around lesions',
          'Premature defoliation starting with lower leaves',
          'Dark, sunken lesions on tubers'
        ],
        diseasecycle: 'The fungus overwinters in infected plant debris and soil. Spores are produced and spread by wind and rain splash to infect new potato plants.',
        environmentalConditions: 'Disease development is favored by warm temperatures (75-85°F), alternating wet and dry conditions, and plant stress.',
        culturalManagement: [
          'Crop rotation with non-solanaceous crops',
          'Remove and destroy infected plant debris',
          'Maintain plant vigor through proper nutrition and irrigation',
          'Avoid water stress'
        ],
        chemicalManagement: [
          'Preventive fungicide applications',
          'Chlorothalonil, mancozeb, and copper-based fungicides',
          'Begin applications when conditions favor disease development'
        ],
        resistantVarieties: [
          'Some potato varieties show moderate resistance'
        ],
      ),

      PlantDisease(
        id: 'potato_late_blight',
        name: 'Potato Late Blight',
        scientificName: 'Phytophthora infestans',
        crop: 'Potato',
        pathogenType: 'Oomycete',
        description: 'Late blight of potato is caused by Phytophthora infestans, historically the most devastating potato disease. It can rapidly destroy entire fields under favorable conditions.',
        symptoms: [
          'Water-soaked lesions on leaves that rapidly turn brown to black',
          'White sporulation on undersides of leaves during humid conditions',
          'Brown to black lesions on stems',
          'Reddish-brown, dry rot on tubers',
          'Entire plants can be killed within days'
        ],
        diseasecycle: 'The pathogen overwinters in infected tubers and can survive in plant debris. Spores are produced during cool, wet weather and spread rapidly by wind and rain.',
        environmentalConditions: 'Disease development is explosive under cool (60-70°F), wet conditions with high humidity and extended leaf wetness.',
        culturalManagement: [
          'Plant certified disease-free seed potatoes',
          'Destroy cull piles and volunteer potatoes',
          'Improve air circulation',
          'Avoid overhead irrigation during cool, humid periods'
        ],
        chemicalManagement: [
          'Preventive fungicide applications are essential',
          'Copper-based fungicides, chlorothalonil, and mancozeb',
          'Systemic fungicides for severe disease pressure',
          'Apply before symptoms appear and continue regularly'
        ],
        resistantVarieties: [
          'Some varieties have resistance genes but complete resistance is rare'
        ],
      ),

      // Add healthy classes
      PlantDisease(
        id: 'apple_healthy',
        name: 'Apple Healthy',
        scientificName: 'N/A',
        crop: 'Apple',
        pathogenType: 'N/A',
        description: 'Healthy apple plant with no visible disease symptoms.',
        symptoms: ['No disease symptoms present'],
        diseasecycle: 'N/A',
        environmentalConditions: 'N/A',
        culturalManagement: ['Maintain good cultural practices to prevent disease'],
        chemicalManagement: ['No treatment needed'],
        resistantVarieties: ['N/A'],
      ),

      PlantDisease(
        id: 'tomato_healthy',
        name: 'Tomato Healthy',
        scientificName: 'N/A',
        crop: 'Tomato',
        pathogenType: 'N/A',
        description: 'Healthy tomato plant with no visible disease symptoms.',
        symptoms: ['No disease symptoms present'],
        diseasecycle: 'N/A',
        environmentalConditions: 'N/A',
        culturalManagement: ['Maintain good cultural practices to prevent disease'],
        chemicalManagement: ['No treatment needed'],
        resistantVarieties: ['N/A'],
      ),

      PlantDisease(
        id: 'corn_healthy',
        name: 'Corn Healthy',
        scientificName: 'N/A',
        crop: 'Corn',
        pathogenType: 'N/A',
        description: 'Healthy corn plant with no visible disease symptoms.',
        symptoms: ['No disease symptoms present'],
        diseasecycle: 'N/A',
        environmentalConditions: 'N/A',
        culturalManagement: ['Maintain good cultural practices to prevent disease'],
        chemicalManagement: ['No treatment needed'],
        resistantVarieties: ['N/A'],
      ),

      PlantDisease(
        id: 'potato_healthy',
        name: 'Potato Healthy',
        scientificName: 'N/A',
        crop: 'Potato',
        pathogenType: 'N/A',
        description: 'Healthy potato plant with no visible disease symptoms.',
        symptoms: ['No disease symptoms present'],
        diseasecycle: 'N/A',
        environmentalConditions: 'N/A',
        culturalManagement: ['Maintain good cultural practices to prevent disease'],
        chemicalManagement: ['No treatment needed'],
        resistantVarieties: ['N/A'],
      ),

      PlantDisease(
        id: 'tomato_tomato_yellow_leaf_curl_virus',
        name: 'Tomato Yellow Leaf Curl Virus',
        scientificName: 'Tomato yellow leaf curl virus (TYLCV)',
        crop: 'Tomato',
        pathogenType: 'Virus',
        description: 'Tomato yellow leaf curl virus (TYLCV) is a devastating viral disease of tomato, causing severe yield losses in many regions. It is transmitted by the whitefly Bemisia tabaci.',
        symptoms: [
          'Upward curling and yellowing of leaves',
          'Stunted plant growth',
          'Reduced fruit set and yield',
          'Thickened, brittle leaves',
          'Shortened internodes',
          'Flower drop'
        ],
        diseasecycle: 'TYLCV is transmitted in a persistent manner by the whitefly Bemisia tabaci. The virus is not seed-borne and does not survive in soil, but can persist in infected plants and weeds.',
        environmentalConditions: 'Disease incidence is higher in warm climates and during periods of high whitefly activity.',
        culturalManagement: [
          'Use virus-free transplants',
          'Remove and destroy infected plants promptly',
          'Control whitefly populations',
          'Use reflective mulches to repel whiteflies',
          'Practice crop rotation and weed management'
        ],
        chemicalManagement: [
          'Apply insecticides to control whitefly vectors',
          'Use insecticide-treated seedling trays',
          'Monitor and manage whitefly populations regularly'
        ],
        resistantVarieties: [
          'Plant TYLCV-resistant tomato varieties if available'
        ],
      ),

      // Cherry Diseases
      PlantDisease(
        id: 'cherry_healthy',
        name: 'Cherry Healthy',
        scientificName: 'N/A',
        crop: 'Cherry',
        pathogenType: 'N/A',
        description: 'Healthy cherry plant with no visible disease symptoms.',
        symptoms: ['No disease symptoms present'],
        diseasecycle: 'N/A',
        environmentalConditions: 'N/A',
        culturalManagement: ['Maintain good cultural practices to prevent disease'],
        chemicalManagement: ['No treatment needed'],
        resistantVarieties: ['N/A'],
      ),

      // Grape Diseases
      PlantDisease(
        id: 'grape_black_rot',
        name: 'Grape Black Rot',
        scientificName: 'Guignardia bidwellii',
        crop: 'Grape',
        pathogenType: 'Fungus',
        description: 'Black rot is a common fungal disease of grapes.',
        symptoms: ['Small brown spots on leaves', 'Black lesions on fruit'],
        diseasecycle: 'Overwinters in mummified fruit and canes.',
        environmentalConditions: 'Favored by warm, humid weather.',
        culturalManagement: ['Remove mummified fruit', 'Prune infected canes'],
        chemicalManagement: ['Apply fungicides as needed'],
        resistantVarieties: ['Some American grape varieties'],
      ),
      PlantDisease(
        id: 'grape_esca',
        name: 'Grape Esca (Black Measles)',
        scientificName: 'Complex of fungi',
        crop: 'Grape',
        pathogenType: 'Fungus',
        description: 'Esca is a trunk disease of grapevines.',
        symptoms: ['Tiger-stripe leaf symptoms', 'Black spots on berries'],
        diseasecycle: 'Fungi infect through pruning wounds.',
        environmentalConditions: 'Favored by old vines and stress.',
        culturalManagement: ['Remove infected wood', 'Avoid large pruning wounds'],
        chemicalManagement: ['No effective chemical control'],
        resistantVarieties: ['None'],
      ),
      PlantDisease(
        id: 'grape_leaf_blight',
        name: 'Grape Leaf Blight (Isariopsis Leaf Spot)',
        scientificName: 'Isariopsis clavispora',
        crop: 'Grape',
        pathogenType: 'Fungus',
        description: 'Leaf blight causes brown spots on grape leaves.',
        symptoms: ['Brown angular spots on leaves'],
        diseasecycle: 'Overwinters in fallen leaves.',
        environmentalConditions: 'Favored by wet weather.',
        culturalManagement: ['Remove fallen leaves', 'Improve air circulation'],
        chemicalManagement: ['Apply fungicides as needed'],
        resistantVarieties: ['Some American grape varieties'],
      ),
      PlantDisease(
        id: 'grape_healthy',
        name: 'Grape Healthy',
        scientificName: 'N/A',
        crop: 'Grape',
        pathogenType: 'N/A',
        description: 'Healthy grape plant with no visible disease symptoms.',
        symptoms: ['No disease symptoms present'],
        diseasecycle: 'N/A',
        environmentalConditions: 'N/A',
        culturalManagement: ['Maintain good cultural practices to prevent disease'],
        chemicalManagement: ['No treatment needed'],
        resistantVarieties: ['N/A'],
      ),

      // Orange Diseases
      PlantDisease(
        id: 'orange_huanglongbing',
        name: 'Orange Huanglongbing (Citrus Greening)',
        scientificName: 'Candidatus Liberibacter spp.',
        crop: 'Orange',
        pathogenType: 'Bacterium',
        description: 'Huanglongbing is a serious citrus disease.',
        symptoms: ['Yellow shoots', 'Mottled leaves', 'Misshapen fruit'],
        diseasecycle: 'Spread by psyllid insects.',
        environmentalConditions: 'Favored by warm climates.',
        culturalManagement: ['Remove infected trees', 'Control psyllids'],
        chemicalManagement: ['Apply insecticides to control psyllids'],
        resistantVarieties: ['None'],
      ),

      // Peach Diseases
      PlantDisease(
        id: 'peach_bacterial_spot',
        name: 'Peach Bacterial Spot',
        scientificName: 'Xanthomonas arboricola pv. pruni',
        crop: 'Peach',
        pathogenType: 'Bacterium',
        description: 'Bacterial spot affects peach leaves and fruit.',
        symptoms: ['Dark spots on leaves and fruit'],
        diseasecycle: 'Overwinters in twigs and buds.',
        environmentalConditions: 'Favored by wet, warm weather.',
        culturalManagement: ['Prune infected twigs', 'Avoid overhead irrigation'],
        chemicalManagement: ['Apply copper sprays'],
        resistantVarieties: ['Some peach varieties'],
      ),
      PlantDisease(
        id: 'peach_healthy',
        name: 'Peach Healthy',
        scientificName: 'N/A',
        crop: 'Peach',
        pathogenType: 'N/A',
        description: 'Healthy peach plant with no visible disease symptoms.',
        symptoms: ['No disease symptoms present'],
        diseasecycle: 'N/A',
        environmentalConditions: 'N/A',
        culturalManagement: ['Maintain good cultural practices to prevent disease'],
        chemicalManagement: ['No treatment needed'],
        resistantVarieties: ['N/A'],
      ),

      // Pepper Diseases
      PlantDisease(
        id: 'pepper_bell_bacterial_spot',
        name: 'Pepper Bell Bacterial Spot',
        scientificName: 'Xanthomonas campestris pv. vesicatoria',
        crop: 'Pepper',
        pathogenType: 'Bacterium',
        description: 'Bacterial spot affects bell pepper leaves and fruit.',
        symptoms: ['Water-soaked spots on leaves and fruit'],
        diseasecycle: 'Overwinters in plant debris and seed.',
        environmentalConditions: 'Favored by warm, wet weather.',
        culturalManagement: ['Use disease-free seed', 'Rotate crops'],
        chemicalManagement: ['Apply copper-based sprays'],
        resistantVarieties: ['Some bell pepper varieties'],
      ),
      PlantDisease(
        id: 'pepper_bell_healthy',
        name: 'Pepper Bell Healthy',
        scientificName: 'N/A',
        crop: 'Pepper',
        pathogenType: 'N/A',
        description: 'Healthy bell pepper plant with no visible disease symptoms.',
        symptoms: ['No disease symptoms present'],
        diseasecycle: 'N/A',
        environmentalConditions: 'N/A',
        culturalManagement: ['Maintain good cultural practices to prevent disease'],
        chemicalManagement: ['No treatment needed'],
        resistantVarieties: ['N/A'],
      ),

      // Squash Diseases
      PlantDisease(
        id: 'squash_powdery_mildew',
        name: 'Squash Powdery Mildew',
        scientificName: 'Podosphaera xanthii',
        crop: 'Squash',
        pathogenType: 'Fungus',
        description: 'Powdery mildew is a common disease of squash.',
        symptoms: ['White powdery spots on leaves and stems'],
        diseasecycle: 'Overwinters in plant debris.',
        environmentalConditions: 'Favored by dry, warm weather.',
        culturalManagement: ['Remove infected debris', 'Plant resistant varieties'],
        chemicalManagement: ['Apply fungicides as needed'],
        resistantVarieties: ['Some squash varieties'],
      ),

      // Strawberry Diseases
      PlantDisease(
        id: 'strawberry_leaf_scorch',
        name: 'Strawberry Leaf Scorch',
        scientificName: 'Diplocarpon earlianum',
        crop: 'Strawberry',
        pathogenType: 'Fungus',
        description: 'Leaf scorch causes brown spots on strawberry leaves.',
        symptoms: ['Purple to brown spots on leaves'],
        diseasecycle: 'Overwinters in infected leaves.',
        environmentalConditions: 'Favored by wet, cool weather.',
        culturalManagement: ['Remove infected leaves', 'Improve air circulation'],
        chemicalManagement: ['Apply fungicides as needed'],
        resistantVarieties: ['Some strawberry varieties'],
      ),
      PlantDisease(
        id: 'strawberry_healthy',
        name: 'Strawberry Healthy',
        scientificName: 'N/A',
        crop: 'Strawberry',
        pathogenType: 'N/A',
        description: 'Healthy strawberry plant with no visible disease symptoms.',
        symptoms: ['No disease symptoms present'],
        diseasecycle: 'N/A',
        environmentalConditions: 'N/A',
        culturalManagement: ['Maintain good cultural practices to prevent disease'],
        chemicalManagement: ['No treatment needed'],
        resistantVarieties: ['N/A'],
      ),

      // Tomato Diseases
      PlantDisease(
        id: 'tomato_leaf_mold',
        name: 'Tomato Leaf Mold',
        scientificName: 'Passalora fulva',
        crop: 'Tomato',
        pathogenType: 'Fungus',
        description: 'Leaf mold causes yellow spots and mold on tomato leaves.',
        symptoms: ['Yellow spots on upper leaf surface', 'Olive-green mold on underside'],
        diseasecycle: 'Overwinters in plant debris and seed.',
        environmentalConditions: 'Favored by high humidity and moderate temperatures.',
        culturalManagement: ['Improve air circulation', 'Avoid overhead irrigation'],
        chemicalManagement: ['Apply fungicides as needed'],
        resistantVarieties: ['Some tomato varieties'],
      ),
      PlantDisease(
        id: 'tomato_septoria_leaf_spot',
        name: 'Tomato Septoria Leaf Spot',
        scientificName: 'Septoria lycopersici',
        crop: 'Tomato',
        pathogenType: 'Fungus',
        description: 'Septoria leaf spot causes small spots on tomato leaves.',
        symptoms: ['Small, circular spots with dark borders'],
        diseasecycle: 'Overwinters in plant debris.',
        environmentalConditions: 'Favored by wet, humid weather.',
        culturalManagement: ['Remove infected leaves', 'Rotate crops'],
        chemicalManagement: ['Apply fungicides as needed'],
        resistantVarieties: ['Some tomato varieties'],
      ),
      PlantDisease(
        id: 'tomato_spider_mites',
        name: 'Tomato Spider Mites',
        scientificName: 'Tetranychus urticae',
        crop: 'Tomato',
        pathogenType: 'Mite',
        description: 'Spider mites cause stippling and webbing on tomato leaves.',
        symptoms: ['Yellow stippling', 'Fine webbing on leaves'],
        diseasecycle: 'Mites reproduce rapidly in hot, dry conditions.',
        environmentalConditions: 'Favored by hot, dry weather.',
        culturalManagement: ['Spray with water', 'Introduce predatory mites'],
        chemicalManagement: ['Apply miticides if needed'],
        resistantVarieties: ['None'],
      ),
      PlantDisease(
        id: 'tomato_target_spot',
        name: 'Tomato Target Spot',
        scientificName: 'Corynespora cassiicola',
        crop: 'Tomato',
        pathogenType: 'Fungus',
        description: 'Target spot causes concentric lesions on tomato leaves.',
        symptoms: ['Brown spots with concentric rings'],
        diseasecycle: 'Overwinters in plant debris.',
        environmentalConditions: 'Favored by warm, humid weather.',
        culturalManagement: ['Remove infected debris', 'Rotate crops'],
        chemicalManagement: ['Apply fungicides as needed'],
        resistantVarieties: ['Some tomato varieties'],
      ),
      PlantDisease(
        id: 'tomato_mosaic_virus',
        name: 'Tomato Mosaic Virus',
        scientificName: 'Tomato mosaic virus (ToMV)',
        crop: 'Tomato',
        pathogenType: 'Virus',
        description: 'Tomato mosaic virus causes mottling and distortion of tomato leaves.',
        symptoms: ['Mottled, light and dark green leaves', 'Distorted growth'],
        diseasecycle: 'Transmitted by contact, seed, and tools.',
        environmentalConditions: 'Favored by cool weather.',
        culturalManagement: ['Use virus-free seed', 'Disinfect tools'],
        chemicalManagement: ['No effective chemical control'],
        resistantVarieties: ['Some tomato varieties'],
      ),
      PlantDisease(
        id: 'corn_maize_healthy',
        name: 'Corn (maize) Healthy',
        scientificName: 'N/A',
        crop: 'Corn',
        pathogenType: 'N/A',
        description: 'Healthy corn (maize) plant with no visible disease symptoms.',
        symptoms: ['No disease symptoms present'],
        diseasecycle: 'N/A',
        environmentalConditions: 'N/A',
        culturalManagement: ['Maintain good cultural practices to prevent disease'],
        chemicalManagement: ['No treatment needed'],
        resistantVarieties: ['N/A'],
      ),

      PlantDisease(
        id: 'unknown', // <-- This must match the id used in MLService when confidence is low
        name: 'Unknown or Not a Plant Disease',
        scientificName: 'N/A',
        crop: 'N/A',
        pathogenType: 'N/A',
        description: 'The uploaded image does not appear to be a supported plant or plant disease. Please try again with a clear image of a plant leaf.',
        symptoms: ['N/A'],
        diseasecycle: 'N/A',
        environmentalConditions: 'N/A',
        culturalManagement: ['N/A'],
        chemicalManagement: ['N/A'],
        resistantVarieties: ['N/A'],
      ),
    ];
  }
}

