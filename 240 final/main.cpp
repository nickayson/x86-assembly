// #Author: Nicholas Ayson
// #Email: nick.ayson@csu.fullerton.edu
// CLASS: 240-05

#include <stdio.h>
extern "C" double harmonic();

int main()
{
	double result_code = -999;
	printf("This is 240-07 programming final by Nicholas Ayson.\n");
	result_code = harmonic();
	printf("The main program received this number and will keep it: %lf\n", result_code);
	printf("End of output.\n");
	return 0;
}
