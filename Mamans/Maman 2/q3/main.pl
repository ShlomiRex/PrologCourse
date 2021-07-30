% houses(List):-
% 	member([_, redHouse, english, _, _, _], List),
% 	member([_, _, spanish, _, _, dog], List),
% 	member([_, greenHouse, _, coffee, _, _], List),
% 	member([_, _, ukrain, tea, _, _], List),
% 	member([WhiteHouseNum, whiteHouse, _, _, _, _], List), member([GreenHouseNum, greenHouse, _, _, _, _], List), (Diff1 is WhiteHouseNum-GreenHouseNum, (Diff1 == 1 ; Diff1 == (-1))),
% 	member([_, _, ukrain, tea, _, _], List),
% 	member([_, _, ukrain, tea, _, _], List),



houses(List):-
	%[NUMBER, COLOR, ORIGIN, DRINK, SMOKE, PET]
    List = [[1, _, norway, _, _, _], [2, blueHouse, _, _, _, _], [3, _, _, milk, _, _], [4, _, _, _, _, _], [5, _, _, _, _, _]],  
    member([_, redHouse, english, _, _, _], List),
    member([_, _, spanish, _, _, dog], List),
    member([_, greenHouse, _, coffee, _, _], List),
    member([_, _, ukraine, tea, _, _], List),
    member([WhiteHouseNum, whiteHouse, _, _, _, _], List), member([GreenHouseNum, greenHouse, _, _, _, _], List), (Diff1 is WhiteHouseNum-GreenHouseNum, (Diff1==1;Diff1==(-1))),
    member([_, _, _, _, mrlboro, cat], List),
    member([YellowHouseNum, yellow, _, _, time, _], List),
    member([FoxPetHouseNum, _, _, _, _, fox], List), member([SmokesMontanaHouseNum, _, _, _, montana, _], List), (Diff2 is FoxPetHouseNum-SmokesMontanaHouseNum, (Diff2 == 1;Diff2==(-1))),
    member([HorsePetHouseNum, _, _, _, _, horse], List), (Diff3 is YellowHouseNum-HorsePetHouseNum, (Diff3==1;Diff3==(-1))),
    member([_, _, _, orange, luckystrike, _], List),
    member([_, _, japan, _, parliament, _], List),
    member([_, _, _, _, _, zebra], List),
    member([_, _, _, water, _, _], List).

answerQuestion(ZebraOwnerOrigin, WaterOwnerOrigin):-
    houses(List),
    member([_, _, ZebraOwnerOrigin, _, _, zebra], List),
    member([_, _, WaterOwnerOrigin, water, _, _], List).
