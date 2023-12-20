//Written by Caleb

state("Freeways")
{
	int firstLevel : 0x0E5D8144;
	byte simulating : 0x12A5E1;
	int tutorialCompleted : 0x126514;
	string3 score : 0x12A5F8;
	int scoreTest : 0xF82B6BF;
}

init
{
	refreshRate = 30; //lots of people seem to do this and it can improve performance 
	vars.startSimulateTime = new Time();
	vars.currentSimulateTime = new Time();

	//full simulation time is around 6.2 seconds but it calculates at 6 and you can exit out so need to compensate for that
	vars.simulateLength = new TimeSpan(60000000); // 6 seconds
}

split
{	
	if(vars.currentSimulateTime.RealTime > vars.simulateLength) //check if we have been simulating longer than the simulate time
	{
		vars.startSimulateTime = timer.CurrentTime; //reset the timer so no chance of splitting again
		vars.currentSimulateTime = new Time(); 
		return true;
	}
	return false;
}

start
{
	if(current.tutorialCompleted != old.tutorialCompleted) // once the game recognises tutorial is completed start splits
		return current.tutorialCompleted == 1;
	return false;
}

reset
{
	if(current.tutorialCompleted != old.tutorialCompleted) // if tutorial hasnt been beaten it means we reset
		return current.tutorialCompleted == 0;
	return false;
}

update
{

	if(old.simulating == 0 && current.simulating == 1) //when we start simulating 
	{
		vars.startSimulateTime = timer.CurrentTime; //set the simulate start time
	}
	
	if(current.simulating == 1)
		vars.currentSimulateTime = timer.CurrentTime - vars.startSimulateTime; //if we are simulating update the timer
	
	return true;
}

