class PagesController < ApplicationController

  def init
    @result = Function.new
    @static = Static.new
    @integral = IntegralCharacteristic.new
    param = get_param(params.require(:pages))
    $params_mu = param[0]
    $params_s = param[1]
    $nst = param[2]
    @result.init($params_mu.to_f, $params_s.to_f, $nst.to_i )
  end

  def result
    init
    get_integral_expectation
    calculate
    render 'index'
  end

  def save_result
    @save = Savefile.new
    @save.get_result_text($inverse_array, $neuman_array,$metro_array)

  end

  def calculate
    graph = @result.get_date_to_graph
    x_and_i = @result.get_arr_i_and_arr_x
    get_integral_result_iv(@integral)
    get_integral_result_nm(@integral)
    get_integral_result_ma(@integral)
    $arr_1 = x_and_i[0]
    $arr_2 = x_and_i[1]
    $arr_3 = graph[0]
    $arr_4 = graph[1]
    $arr_5 = graph[2]
  end

  def get_param(params)
    param_mu = params[:param_mu]
    param_s = params[:param_s]
    nst = params[:nst]
    [param_mu, param_s, nst]
  end

  def get_integral_expectation
    statistic = @static.get_static_info($params_mu.to_f, $params_s.to_f)
    @integral_average = statistic[0].to_f
    @integral_dispersion = statistic[1].round(3).to_f
    @integral_mod = statistic[2].to_f
    @integral_sigma= statistic[3].to_f
  end

  def get_integral_result_iv(result)
    statistic = result.get_integral_char_iv
    $average_iv = statistic[0].to_f
    $dis_iv = statistic[1].to_f
    $mod_iv = statistic[2].to_f
  end

  def get_integral_result_nm(result)
    statistic = result.get_integral_char_nm
    $average_nm = statistic[0].to_f
    $dis_nm = statistic[1].to_f
    $mod_nm = statistic[2].to_f
  end

  def get_integral_result_ma(result)
    statistic = result.get_integral_char_ma
    $average_ma = statistic[0].to_f
    $dis_ma = statistic[1].to_f
    $mod_ma = statistic[2].to_f
  end

end
