CREATE OR REPLACE VIEW ulezvehicleanalysis_firehose AS SELECT CAST(from_iso8601_timestamp(sampletime) AS timestamp) AS sampletime, deviceid, ST_Within(ST_Point(position[1], position[2]), ST_Polygon('polygon((51.6011227905 -0.0173701532,51.6056060815 -0.0254261323,51.6073807432 -0.0290077758,51.6083574993 -0.0301055745,51.6090362139 -0.0303612738,51.6102459821 -0.0305369486,51.6117241445 -0.0318982751,51.6127228698 -0.0343066765,51.613052452 -0.0370290387,51.6129802969 -0.0390846403,51.6124546741 -0.0416158871,51.6117478584 -0.043926794,51.6113918784 -0.0459945021,51.6115650313 -0.0478684665,51.6126831499 -0.0510701942,51.6136455025 -0.0555899638,51.6147223282 -0.0648941883,51.6148823292 -0.0681371273,51.614571731 -0.0708299261,51.6140595202 -0.0763818197,51.6142841837 -0.0790472749,51.6145000726 -0.0816084461,51.6151272939 -0.0830642687,51.6161483901 -0.0847317458,51.6166168228 -0.087334714,51.6165557157 -0.0922976362,51.6162493592 -0.0954348807,51.6159005512 -0.0978554622,51.6145145603 -0.1021323788,51.6124747758 -0.1076903747,51.6122595307 -0.1097516569,51.6126047754 -0.1135570201,51.6123449794 -0.117273395,51.612447937 -0.119264424,51.6136530835 -0.1239066981,51.6142635722 -0.1262587885,51.614926514 -0.1277708453,51.6146130575 -0.1288318754,51.6132601003 -0.1323432565,51.6111817108 -0.1355639789,51.6098014945 -0.1402950578,51.6086621946 -0.1445598578,51.6060980598 -0.1526663162,51.6056618856 -0.1568804146,51.6057784568 -0.1597828037,51.605650082 -0.1618877978,51.6026054321 -0.1702275917,51.6006137213 -0.1745251638,51.5973191364 -0.1795016064,51.5910661122 -0.1905784351,51.5903146208 -0.1924887055,51.5899844829 -0.194097243,51.5896968226 -0.1961599344,51.5898298441 -0.2002001734,51.5897834227 -0.2017975273,51.5894514119 -0.2032920158,51.5886826131 -0.2063993205,51.5878884985 -0.2078550546,51.5868434238 -0.2091497082,51.5854029189 -0.2101179375,51.5827012807 -0.2113443107,51.5816601781 -0.2114046391,51.5804030814 -0.2127642416,51.5788293506 -0.2143071927,51.5775506799 -0.2165789522,51.5765859963 -0.2184965552,51.5755425128 -0.2199044473,51.5741486097 -0.2216108184,51.5732893412 -0.2234671852,51.5719154473 -0.2298434208,51.5707368601 -0.2330783748,51.5699445121 -0.2370390253,51.5691063815 -0.2403178552,51.5678363596 -0.2432147039,51.5663392354 -0.2475439798,51.5653824263 -0.2500297474,51.564054764 -0.2514476624,51.5601779509 -0.2533047866,51.5592265397 -0.2534799682,51.5575553964 -0.2535762759,51.5556616966 -0.252737783,51.5539699852 -0.253542808,51.5530949374 -0.2543735733,51.5527520552 -0.2551838042,51.5519715782 -0.2599961456,51.5515990689 -0.2612060873,51.5483122123 -0.263724041,51.5446671876 -0.2725140513,51.5434143383 -0.2742122865,51.5405454928 -0.2770530284,51.5400247777 -0.2779829789,51.538672449 -0.2800264655,51.5348890862 -0.288307684,51.5342300453 -0.289356821,51.532107414 -0.2922818452,51.5308064638 -0.293127234,51.5295549021 -0.2924912836,51.5258614312 -0.2923449762,51.5249043667 -0.2924377319,51.5232947608 -0.2915875588,51.522122447 -0.2915177142,51.5170800246 -0.2913650742,51.5145687872 -0.2919710111,51.5118379809 -0.2921301127,51.5091698786 -0.2917179509,51.5076750119 -0.2914326543,51.5044919912 -0.2897886959,51.5029838561 -0.2885939654,51.5009433159 -0.2849738645,51.4997155543 -0.2835413567,51.496925232 -0.2820540181,51.494587149 -0.2823694168,51.4920626347 -0.2820662132,51.4890915114 -0.2876361404,51.4844046143 -0.2875274924,51.4826554408 -0.2868538911,51.4818228875 -0.2857481983,51.4809778555 -0.2837901936,51.4798590228 -0.2825248318,51.4789596041 -0.2817059374,51.478067773 -0.2813984219,51.4768655728 -0.2815487748,51.4761190543 -0.2816421139,51.4752906281 -0.2808206301,51.4732364936 -0.2762940491,51.4690579318 -0.2769629596,51.4676051081 -0.2771312548,51.4658213711 -0.2765165529,51.4643331464 -0.2766861805,51.4642040638 -0.2703266792,51.464259044 -0.2692449035,51.4647222051 -0.266954372,51.4648372246 -0.2651316205,51.4651306763 -0.2609721895,51.4652616533 -0.2530684699,51.4650199316 -0.2487589444,51.4652764402 -0.2445439506,51.4648612091 -0.2405253114,51.4643916457 -0.2352585602,51.4636706527 -0.2321611316,51.4629921585 -0.2271868503,51.4625460951 -0.2235106485,51.4616871406 -0.2207029234,51.4607416029 -0.2168759089,51.4603177022 -0.2146764632,51.4596359043 -0.2118619612,51.4584444428 -0.2082153062,51.4577478448 -0.2067654123,51.4569278241 -0.2055114845,51.4566021502 -0.2037989632,51.4567307774 -0.2006122571,51.4568776351 -0.1986178105,51.4573797669 -0.1963202339,51.4570587562 -0.1942358459,51.456643191 -0.1926045594,51.4566186838 -0.191014573,51.4571319085 -0.1874715987,51.4577265506 -0.1846071659,51.458050774 -0.1803329502,51.458401409 -0.175489339,51.4605233712 -0.1696227312,51.4607552803 -0.1670996516,51.4610592418 -0.1615756782,51.4612681751 -0.1567942136,51.4595246079 -0.1565235235,51.4568958083 -0.1541294236,51.4554250093 -0.1508934587,51.4539896138 -0.1476562645,51.4538581147 -0.1460708526,51.4534045941 -0.144328081,51.4523799003 -0.1423811472,51.4509919885 -0.1421534784,51.4496428607 -0.1376636563,51.4477388808 -0.131776648,51.4472088063 -0.1296965146,51.445193658 -0.1244832964,51.4447167985 -0.1225846084,51.444242076 -0.1217520548,51.4429875991 -0.1165781067,51.4422544674 -0.1151315019,51.4411983617 -0.1134711663,51.4406068542 -0.1098038136,51.4403017082 -0.1062950736,51.4409319655 -0.105757901,51.4405806219 -0.1037845007,51.4398071603 -0.102055941,51.4392383179 -0.0998077465,51.4393225938 -0.0984412298,51.439973555 -0.096994328,51.4408234945 -0.094687149,51.4410412559 -0.0928037894,51.4411817187 -0.0905260657,51.4409309371 -0.0882078352,51.4415902781 -0.0851132676,51.4419199168 -0.0835660134,51.4420619626 -0.0814016965,51.4428153858 -0.0757792891,51.4434905094 -0.0732762751,51.4431198314 -0.070168028,51.4432550685 -0.0676063187,51.4420256295 -0.0662382837,51.4410416829 -0.0646895763,51.4407417134 -0.0628155175,51.4406238669 -0.058743671,51.4402101664 -0.0573412194,51.4393155217 -0.0547666632,51.4393751844 -0.0540825552,51.440122878 -0.0542212648,51.440182324 -0.0533565837,51.4402970371 -0.0518851983,51.4400355047 -0.0511012048,51.4404086801 -0.0500629982,51.4412883447 -0.0474696219,51.4423160601 -0.0473689658,51.4423831873 -0.0428790541,51.4420874426 -0.0400518037,51.4424206061 -0.0366296706,51.4423863541 -0.0345863925,51.4420692192 -0.0326119827,51.4421930551 -0.0315275807,51.4431499609 -0.0293279995,51.4434126707 -0.0280670828,51.4432910333 -0.0271635889,51.4440820166 -0.0256526642,51.4445210808 -0.0243272551,51.44481167 -0.0226107447,51.4449612472 -0.0209570228,51.4448778228 -0.0202221317,51.4457195383 -0.019617735,51.445959221 -0.0190960812,51.4460512076 -0.0182401501,51.4458508436 -0.0168854707,51.445488442 -0.0143451084,51.4451575299 -0.0115760738,51.4449999381 -0.0064707277,51.4450145334 -0.0010738383,51.4451698526 0.0043859302,51.4454954144 0.0061041879,51.4458769209 0.0125826751,51.44626872 0.0148291092,51.4469993537 0.0177583183,51.4477840727 0.0216556724,51.4494920558 0.0275823686,51.4510745866 0.0325381465,51.4527849452 0.0362501018,51.4569749088 0.0422889095,51.4582150804 0.0444466345,51.4593370282 0.0472809377,51.4604501407 0.0485808501,51.4609013233 0.0491692559,51.4618347149 0.0496666363,51.4656152409 0.0515967502,51.4674071932 0.0526433554,51.4692256621 0.0542026821,51.4709910702 0.0547365876,51.4731830921 0.0552329629,51.4745533687 0.056033563,51.4763522534 0.0566828706,51.4776486504 0.0576507635,51.4788336008 0.0588978544,51.4799840534 0.0600866786,51.482967836 0.0619834802,51.4840368838 0.0617474097,51.485339146 0.0623747847,51.4870975107 0.0633069929,51.492862361 0.0608724742,51.4938113906 0.0609944071,51.4947365082 0.0608655812,51.4951856272 0.0615682727,51.4951686406 0.0625341839,51.4985215464 0.0616050693,51.4987585779 0.0627218675,51.4989851497 0.063502726,51.5000147199 0.063492347,51.5000180969 0.0653124814,51.5003003093 0.0674294032,51.5008721887 0.0692184026,51.5012037758 0.0705414244,51.5017785558 0.0707743188,51.5025920271 0.0703200701,51.5053079593 0.0712963935,51.5065514443 0.0712390979,51.5075475504 0.0711135457,51.5084924247 0.07107882,51.5097870428 0.0709308053,51.5116313711 0.0710144842,51.5141940406 0.0706187135,51.5150372541 0.071112113,51.5163019797 0.0718522442,51.5197567163 0.0732038313,51.5225686659 0.0727625471,51.5253250397 0.0734566883,51.5263321814 0.0727057915,51.5321708877 0.0717188707,51.5365156326 0.068899446,51.5388226472 0.0668979914,51.5403932018 0.0663999453,51.5416659578 0.0666852902,51.5437770088 0.0677486158,51.545966943 0.0683602873,51.5477088109 0.0682115296,51.5494871639 0.0680074507,51.5525523856 0.0672924817,51.5550925491 0.0661549371,51.5570822637 0.0640242416,51.5593817136 0.0604269021,51.5608718486 0.0584442778,51.562899015 0.056200842,51.5646312982 0.0545703943,51.5673676688 0.0523586528,51.5694211416 0.0506283701,51.5711928018 0.0487715203,51.5737422788 0.0460128407,51.5762525132 0.0435872787,51.5796989539 0.0413491261,51.5827513818 0.0398780196,51.5847344646 0.0395805087,51.5870093525 0.0393975677,51.5895827621 0.0383730997,51.5916271446 0.03715403,51.5937533446 0.0353115165,51.594920839 0.0334830348,51.595489388 0.0313997567,51.5960292176 0.0289162188,51.59640739 0.0255136302,51.5957244397 0.0218927836,51.5952257982 0.0199330706,51.595254699 0.0141214526,51.5956841273 0.0119010895,51.5963711342 0.0090416854,51.5978983833 0.0048346572,51.5989007398 0.0022570131,51.5996921738 -0.0004439305,51.6001240461 -0.0028757083,51.6003730825 -0.0070823047,51.6003620375 -0.0106166079,51.6005063065 -0.0149420972,51.6011227905 -0.0173701532))')) AS insidezone FROM "location-analytics-glue-database"."firehose" ORDER BY sampletime ASC;