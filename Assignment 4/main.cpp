#include <cstring>
#include <iomanip>
#include <iostream>

extern "C" double interview( char[], double );

int main()
{
  double offer = -999;
  char name[100];
  std::string first;
  std::string last;
  double salary;

  std::cout << "Welcome to Software Analysis by Paramount Programmers, Inc.\n";
  std::cout << "Please enter your first and last names and press enter: ";

  std::cin >> first >> last;                         // Take first and last name

  strcpy(name, ( first + ' ' + last ).c_str());    // Combine first and last name

  std::cout << "Thank you " << name << ". Our records show that you applied for employment her with our agency a week ago.\n";
  std::cout << "Please enter your expected annual salary when employed at Paramount: ";
  std::cin >> salary;
  std::cout << "Your interview with Ms Linda Fenster, Personnel Manager, will begin shortly.\n";

  offer = interview(name, salary);    // Get the interview offer

  if(offer < 50000)    // offer < 50k
  {
    std::cout << "Hello " << name << " I am the receptionist\n";
    std::cout << "We have an opening for you in the company cafeteria for $" << std::fixed << std::setprecision( 2 ) << offer << " annually\n";
    std::cout << "Take your time to let us know your decision.\n";
    std::cout << "Bye\n";
  }
  else if(offer < 200000)    // 50k <= offer < 200k
  {
    std::cout << "Hello " << name << " I am the receptionist\n";
    std::cout << "This envelope contains your job offer with starting salary $" << std::fixed << std::setprecision( 2 ) << offer << ".  Please check back on Monday morning at 8am.\n";
    std::cout << "Bye\n";
  }
  else    // offer >= 200k
  {
    std::cout << "Hello Mr Sawyer. I am the receptionist.\n";
    std::cout << "This envelope has your job offer starting at $" << std::fixed << std::setprecision( 2 ) << offer << " annual. Please start any time you like. In the middle time our CTO wishes to have dinner with you.\n";
    std::cout << "Have very nice evening Mr Sawyer\n";
  }
  return 0;
}    //End of main
