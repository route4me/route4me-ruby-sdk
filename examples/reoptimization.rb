require 'route4me'
require './helper'

problem = Route4me::OptimizationProblem.update(
  :optimization_problem_id => 'F2FEA85DA7EFCE180CAD70704816347A',
  :parameters => { :reoptimize => true },
  :addresses => addresses,
  :reoptimize => true
)
