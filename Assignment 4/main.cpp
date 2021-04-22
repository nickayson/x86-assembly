// ;********************************************************************************************
// ; Program name:          interview                                                          *
// ; Programming Language:  x86 Assembly                                                       *
// ; Program Description:   This program asks a user to play the role of an interviewee asking for salary*
// ;                       returns the salary the company is willing to give.                   *
// ; Built on: Tuffix 2020
// ;                                                                                            *
// ; ********************************************************************************************
// ;  Author Information:                                                                       *
// ;  Name:         Nicholas Ayson                                                              *
// ;  Email:        nick.ayson@csu.fullerton.edu                                                *
// ;  Institution:  California State University - Fullerton                                     *
// ;  Course:       CPSC 240-05 Assembly Language                                               *
// ;                                                                                            *
// ; ********************************************************************************************
// ;  Copyright (C) 2020 Nicholas Ayson                                                         *
// ;  This program is free software: you can redistribute it and/or modify it under the terms   *
// ;  of the GNU General Public License version 3 as published by the Free Software Foundation. *
// ;  This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY  *
// ;  without even the implied Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. *
// ;  See the GNU General Public License for more details. A copy of the GNU General Public     *
// ;  License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
// ;                                                                                            *
// ; ********************************************************************************************
// ;  Program information                                                                       *
// ;    Program name: interview                                                                 *
// ;    Programming languages: One module in C++, One in asm, three txt files                   *
// ;    Files in this program: interview.asm, main.cpp, chris.txt, csmajor.txt,social.txt       *
// ;                                                                                            *
// ; ********************************************************************************************
// ;  This File                                                                                 *
// ;     Name:     main.cpp                                                                     *
// ;     Purpose:   displays initial messages of the interviewer  and gets n names and salary   *
// ;                 if statements to see if the offer meets the requirements from name and salary*
// ;                  This displays the messages depending on this offer                        *
// ; ********************************************************************************************

#include <cstring>
#include <iomanip>
#include <iostream>

extern "C" double interview(char[], double);

int main()
{
  double offer = -999;    //offer set at unrealistic number
  char name[100];       //allows 100 characters
  std::string first;
  std::string last;
  double salary;

  std::cout << "Welcome to Software Analysis by Paramount Programmers, Inc.\n";
  std::cout << "Please enter your first and last names and press enter: ";
  std::cin >> first >> last;    // Take first and last name

  strcpy(name,(first + ' ' + last).c_str());    // Combine first and last name

  std::cout << "Thank you " << name << ". Our records show that you applied for employment her with our agency a week ago.\n";
  std::cout << "Please enter your expected annual salary when employed at Paramount: ";
  std::cin >> salary;
  std::cout << "Your interview with Ms Linda Fenster, Personnel Manager, will begin shortly.\n";

  offer = interview(name, salary);

  if(offer < 50000)
  {
    //set setprecision at 2 decimal places
    std::cout << "Hello " << name << " I am the receptionist\n";
    std::cout << "We have an opening for you in the company cafeteria for $" << std::fixed << std::setprecision(2) << offer << " annually\n";
    std::cout << "Take your time to let us know your decision.\n";
    std::cout << "Bye\n";
  }
  else if(offer < 200000)
  {
    std::cout << "Hello " << name << " I am the receptionist\n";
    std::cout << "This envelope contains your job offer with starting salary $" << std::fixed << std::setprecision(2) << offer << ".  Please check back on Monday morning at 8am.\n";
    std::cout << "Bye\n";
  }
  else    // offer >= 200k
  {
    std::cout << "Hello Mr Sawyer. I am the receptionist.\n";
    std::cout << "This envelope has your job offer starting at $" << std::fixed << std::setprecision(2) << offer << " annual. Please start any time you like. In the middle time our CTO wishes to have dinner with you.\n";
    std::cout << "Have very nice evening Mr Sawyer\n";
  }
  return 0;
}    //End of main
