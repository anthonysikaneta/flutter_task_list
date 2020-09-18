#include <chrono>
#include <iostream>
#include <thread>
#include <vector>
#include <sstream>

using namespace std;

class Task
{
  std::vector<std::thread> _tasks;

public:
  Task();

  std::vector<string> threadIds;
  void start_task(int numsecs);
  std::vector<std::thread> *get_tasks();
  std::vector<std::thread> *generate_tasks(int32_t size, int32_t duration);

  ~Task()
  {
    // delete _tasks;
  }
};
