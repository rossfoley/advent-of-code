require 'digest'

class Node
  attr_reader :state, :action, :parent

  def initialize state, action, parent = nil
    @state = state
    @action = action
    @parent = parent
  end

  def state_with_path
    [@state, path]
  end

  def positions
    if @parent
      @parent.positions << @state
    else
      [@state]
    end
  end

  def path
    if @parent
      @parent.path + @action
    else
      @action
    end
  end

  def steps
    path.size
  end
end

class Vault
  ACTIONS = [
    {name: 'U', dx: 0,  dy: -1, md5_pos: 0},
    {name: 'D', dx: 0,  dy: 1,  md5_pos: 1},
    {name: 'L', dx: -1, dy: 0,  md5_pos: 2},
    {name: 'R', dx: 1,  dy: 0,  md5_pos: 3}
  ]

  def initialize input
    @input = input
  end

  def start_state
    [0, 0]
  end

  def end_state
    [3, 3]
  end

  def search
    fringe = [Node.new(start_state, '')]
    explored = []

    while true
      current_node = fringe.shift
      break if current_node.nil?

      next if explored.include? current_node.state_with_path
      return current_node if end_state == current_node.state

      successors(*current_node.state_with_path).each do |successor|
        fringe.push Node.new(successor[:state], successor[:action], current_node)
      end

      explored.push current_node.state_with_path
    end
  end

  def search_all
    fringe = [Node.new(start_state, '')]
    explored = []
    path_lengths = []

    while true
      current_node = fringe.pop
      return path_lengths.max if current_node.nil?

      next if explored.include? current_node.state_with_path
      if end_state == current_node.state
        path_lengths << current_node.steps if end_state == current_node.state
        next
      end

      successors(*current_node.state_with_path).each do |successor|
        fringe.push Node.new(successor[:state], successor[:action], current_node)
      end

      explored.push current_node.state_with_path
    end
  end

  def successors state, path
    x, y = state
    hash = Digest::MD5.hexdigest "#{@input}#{path}"

    legal_actions = ACTIONS.select do |action|
      in_range = (0..3).include?(x + action[:dx]) && (0..3).include?(y + action[:dy])
      legal_md5 = 'bcdef'.include? hash[action[:md5_pos]]
      in_range && legal_md5
    end

    legal_actions.map do |action|
      {state: [x + action[:dx], y + action[:dy]], action: action[:name]}
    end
  end
end


vault = Vault.new 'ioramepc'
solution = vault.search
puts "[Part 1] #{solution.path}"

max_length = vault.search_all
puts "[Part 2] #{max_length}"
