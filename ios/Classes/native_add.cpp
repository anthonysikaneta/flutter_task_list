#include "native_add.hpp"

void start_task(int numsecs)
{
  std::this_thread::sleep_for(std::chrono::seconds(numsecs));
  std::cout << numsecs << "\n";
  std::cout << "From Thread ID : " << std::this_thread::get_id() << "\n";
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
int32_t
generate_tasks(int32_t size, int32_t duration)
{
  std::vector<std::thread> threads;

  std::function<void(int)> snooze = start_task;

  for (size_t i = 0; i < size; i++)
  {
    threads.push_back(std::thread(snooze, duration));
  }

  // Iterate over the thread vector
  for (std::thread &th : threads)
  {
    // If thread Object is Joinable then Join that thread.
    if (th.joinable())
      th.join();
  }

  return threads.size();
}
