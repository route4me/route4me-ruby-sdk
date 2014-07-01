module Route4me
  class OptimizationProblem
    def self.url
      '/api.v4/optimization_problem.php'
    end

    def self.get(params={})
      get = Util.extract(params, %i(
        optimization_problem_id wait_for_final_state state limit offset
      ))

      optimization = Route4me.request(:get, self.url, get: get)
      if (optimization['optimizations']).nil?
        optimization
      else
        optimization['optimizations']
      end
    end

    def self.optimize(params={})
      json = Util.extract(params, %i(addresses parameters))
      get = Util.extract(params, %i(
        directions format route_path_output optimized_callback_url
      ))
      Route4me.request(:post, self.url, get: get, json: json)
    end

    def self.update(params={})
      json = Util.extract(params, %i(addresses parameters))
      get = Util.extract(params, %i(
        optimization_problem_id directions format route_path_output reoptimize
      ))
      Route4me.request(:post, self.url, get: get, json: json)
    end
  end
end
