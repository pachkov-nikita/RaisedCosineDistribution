class Static

  def get_static_info(param_mu, param_s)
    average_value = param_mu
    dispersion = (param_s.to_f * param_s.to_f) * ((1.0/3.0) - (2/(Math::PI* Math::PI)))
    mod = param_mu
    sigma = Math.sqrt(dispersion)
    [average_value, dispersion, mod, sigma.round(4)]
  end

end
