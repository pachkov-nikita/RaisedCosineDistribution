class Savefile

  def file_write(str)
    File.write("save_random_value.txt", str)
  end

  def get_text(inverse_result, neumann_result, metro_result)

    string = "Генерування випадкових величин.
  1.Метод зворотньої фунції:
  #{inverse_result}

  2.Метод Неймана:
  #{neumann_result}

  3.Алгоритм Метрополісу:
  #{metro_result}"
    return string
  end

  def get_result_text(inverse_result, neumann_result, metro_result)
    string = get_text(inverse_result, neumann_result, metro_result)
    file_write(string)
  end

end
