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
	refreshRate = 30;
	vars.startSimulateTime = new Time();
	vars.currentSimulateTime = new Time();
	vars.simulateLength = new TimeSpan(60000000); // 6 seconds
}

split
{	
	if(vars.currentSimulateTime.RealTime > vars.simulateLength) //check if we have been simulating longer than the simulate time
	{
		vars.startSimulateTime = timer.CurrentTime;
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
	
	print(vars.currentSimulateTime.ToString());
	return true;
}

