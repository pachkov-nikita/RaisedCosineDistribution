class IntegralCharacteristic

  def get_average_value(arr)
    sum = arr.sum
    count = arr.size
    (sum/count).round(3)
  end

  def get_dispersion(arr)
    x_ = (arr.sum/arr.size).round(3)
    puts x_
    i = 0
    result = 0
    while i < arr.size
      result += ((arr[i] - x_)**2)/(arr.size-1)
      i = i + 1
    end
    result.round(3)
  end

  def get_mod(x)
    f = {}
    fmax = 0
    mod = nil
    x.each do |v|
      f[v] ||= 0
      f[v] += 1
      fmax,mod = f[v], v if f[v] > fmax
    end
    mod
  end

  def get_integral_char_iv
    average_value = get_average_value($inverse_array)
    dispersion = get_dispersion($inverse_array)
    mod = get_mod($inverse_array)
    [average_value, dispersion, mod]
  end

  def get_integral_char_nm
    average_value = get_average_value($neuman_array)
    dispersion = get_dispersion($neuman_array)
    mod = get_mod($neuman_array)
    [average_value, dispersion, mod]
  end

  def get_integral_char_ma
    average_value = get_average_value($metro_array)
    dispersion = get_dispersion($metro_array)
    mod = get_mod($metro_array)
    [average_value, dispersion, mod]
  end

end
