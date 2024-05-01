// Dependencies
#include <iostream>
#include <string>
#include <cstddef>
#include <vector>
#include <array>




// Requirements
    // User registration application. This will allow users to register with the system, 
    // providing both their name and age, and we'll store this information in our own custom type.
    // We'll also provide the ability for a user to be looked up by an ID, retrieving their information.


// Decalartions

using namespace std;

constexpr int INIT_VALUE = 0;
constexpr int NUM_OPTIONS = 3;

// Enum containing options displayed for user
enum class Option{
    DEFAULT,
    ADD_RECORD,
    FETCH_RECORD,
    QUIT
};

Option DEFAULT_OPTION = Option::DEFAULT;


// A wrapper function to print messages on screen
void print_msg(std::string msg)
{
    std::cout << msg;
}


// Menu class contains items to be displayed for user
class Menu{
public:
    std::array<std::string, NUM_OPTIONS> OptionsMenu{"Add Record", "Fetch Record", "Quit"};

    void display()
    {
        for(size_t i=INIT_VALUE; i<OptionsMenu.size(); i++)
        {
           print_msg(to_string(i+1) + ". " + OptionsMenu[i] + "\n");
        }
    }
};


// Class record to hold the data entered by user
class record{
public:
    std::string username;
    size_t age;

    void display()
    {
        print_msg("Username: " + username + "\nAge: " + to_string(age) + "\n");
    }

};



// Operator Overloading for the >> 
std::istream& operator>>(std::istream &input_stream, Option &resulted_option)
{
    int usr_opt = INIT_VALUE;
    input_stream >> usr_opt;

    resulted_option = static_cast<Option> (usr_opt);
    return input_stream;
}



int main()
{
    Option userOption = DEFAULT_OPTION;
    Menu Menu_Options;
    size_t userId = INIT_VALUE;
    std::vector<record> Records_DB;


    print_msg("Please select an option\n");
    print_msg("\nUser SignUp Application\n");
    Menu_Options.display();
    


do{
    print_msg("\nEnter an option\n");
    std::cin >> userOption;

    switch (userOption)
    {
        case Option::ADD_RECORD :
        {
            print_msg("Add User. Please Enter username and age\n");
            record NewRecord;

            print_msg("Usename: ");
            std::cin >> NewRecord.username;
            print_msg("Age: ");
            std::cin >> NewRecord.age;

            print_msg("\nUser Record added successfully\n");

            Records_DB.push_back(NewRecord);
        }
        break;

        case Option::FETCH_RECORD :
        {
            print_msg("Please Enter user ID\n");
            print_msg("User Id: ");

            std::cin >> userId;

            if(userId < Records_DB.size())
                Records_DB[userId].display();
            else
               print_msg("Invalid User Id\n");
        }
        break;

        case Option::QUIT :
        {
            print_msg("Exit code: 0 (Normal Termination) \n");
        }
        break;
    
        default:
        {
            print_msg("Invalid OPtion\n");
        }
        break;
    }

}while(userOption != Option::QUIT);
    
}