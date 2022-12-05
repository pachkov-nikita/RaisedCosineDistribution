class Function

  def init(param_mu, param_s, nst)
    @param_mu = param_mu
    @param_s = param_s
    @nst = nst
    @min = param_mu - param_s
    @max = param_mu + param_s
  end

  def function_pdf = ->(x) {
  (1/(2*@param_s))*(1+Math.cos(((x-@param_mu)/@param_s)*Math::PI))
}

  def function_cdf = ->(x) {
  (0.5 * (1 + ((x-@param_mu)/@param_s) + ((1/Math::PI)*Math.sin(((x-@param_mu)/@param_s)*Math::PI))))
}

def max_value(function)
  arr_pdf = Array.new
  (@min.to_f..@max.to_f).step(0.1) { |x|
    arr_pdf << function.call(x)
  }
  max_value = 0
  arr_pdf.each { |i|
    if i > max_value
      max_value = i
    end
  }
  max_value
end

def neumann_method
  wer = max_value(function_pdf).to_f
  while true
    g1 = rand(0.0..1.0)
    g2 = rand(0.0..1.0)
    x = @min + (g1*(@max - @min))
    y = wer * g2
    if function_pdf.call(x) >= y
      return x
    end
  end
end

def linear_interpolation(x1,x2,y,f_x1,f_x2)
  ((x2-x1) * y - (f_x1 * x2) + (f_x2 * x1))/(f_x2 - f_x1)
end

def inverse_function
  step = (@max-@min)/202
  arr_x = Array.new
  arr_y = Array.new
  (@min..@max).step(step) { |i|
    arr_x << i
    result = function_cdf.call(i)
    arr_y << result
  }
  max_cdf_by_y = max_value(function_cdf).to_f
  random_y = rand(0.0..max_cdf_by_y)
  arr_y << random_y
  new_arr = arr_y.sort {|x,y| x <=> y}
  new_random_index = new_arr.find_index(random_y)
  if new_random_index > 5 && new_random_index < 197
    random_x = linear_interpolation(arr_x[new_random_index-5],arr_x[new_random_index+5], random_y,arr_y[new_random_index-5],arr_y[new_random_index+5])
  elsif new_random_index >= 197
    random_x = linear_interpolation(arr_x[new_random_index-5],arr_x[202], random_y,arr_y[new_random_index-5],arr_y[202])
  else
    random_x = linear_interpolation(arr_x[0],arr_x[new_random_index+5], random_y,arr_y[0],arr_y[new_random_index+5])
  end
  random_x
end

  def metropolis_algorithm
    x0 = rand(@min.to_f..@max.to_f)
    del = 0.2
    result = 0
    (0...100).each {
      y = rand(0.0..1.0)
      x = x0 + (-1+(2 * y))*del
      if x > @min && x <@max
        a = (function_pdf.call(x))/(function_pdf.call(x0))
      else
        a = 0
      end
      if a >=1
        x0 = x
      else
        if rand(0.0..1.0) < a
          x0 = x
        end
      end
      result = x0
    }

    result
  end

  def get_date_to_graph
    ngis = 20 * @param_s.to_i
    modbet_nm = Array.new; modbet_inv = Array.new; modbet_ma = Array.new
    $inverse_array = Array.new; $neuman_array = Array.new; $metro_array = Array.new
    gitbet_nu = Array.new; gitbet_inv = Array.new; gitbet_ma = Array.new
    i = 0
    while i < @nst.to_i
      ksi1 = inverse_function
      $inverse_array << ksi1
      ksi2 = neumann_method
      $neuman_array << ksi2
      ksi3 = metropolis_algorithm
      $metro_array << ksi3
      j = ((ksi1.round(2) - @min) * 100).round
      j = j/10
      n = ((ksi2.round(2) - @min) * 100).round
      n = n/10
      m = ((ksi3.round(2) - @min) * 100).round
      m = m/10
      modbet_inv[j] = modbet_inv[j].to_i + 1
      modbet_nm[n] = modbet_nm[n].to_i + 1
      modbet_ma[m] = modbet_ma[m].to_i + 1
      i = i + 1
    end
    k = 0
    while k <= ngis
      j = k
      gitbet_nu[j] = (modbet_nm[k].to_f/@nst.to_f * 10).round(4)
      gitbet_inv[j] = (modbet_inv[k].to_f/@nst.to_f * 10).round(4)
      gitbet_ma[j] = (modbet_ma[k].to_f/@nst.to_f * 10).round(4)
      k = k + 1
    end
    [gitbet_inv, gitbet_nu, gitbet_ma]
  end

  def get_arr_i_and_arr_x
    i = @min + 0.05
    arr_i = Array.new
    arr_x = Array.new
    while i <= @max
      p_x = function_pdf.call(i)
      arr_i << i.round(2)
      arr_x << p_x.round(4)
      i = i + 0.1
    end
    [arr_i,arr_x]
  end


end