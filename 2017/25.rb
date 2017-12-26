# Deconstructed blueprints manually because I'm not interested in writing a robot to understand text
blueprints = {
  a: {
    0 => {
      write: 1,
      move: :right,
      state: :b
    },
    1 => {
      write: 0,
      move: :left,
      state: :c
    }
  },
  b: {
    0 => {
      write: 1,
      move: :left,
      state: :a
    },
    1 => {
      write: 1,
      move: :left,
      state: :d
    }
  },
  c: {
    0 => {
      write: 1,
      move: :right,
      state: :d
    },
    1 => {
      write: 0,
      move: :right,
      state: :c
    }
  },
  d: {
    0 => {
      write: 0,
      move: :left,
      state: :b
    },
    1 => {
      write: 0,
      move: :right,
      state: :e
    }
  },
  e: {
    0 => {
      write: 1,
      move: :right,
      state: :c
    },
    1 => {
      write: 1,
      move: :left,
      state: :f
    }
  },
  f: {
    0 => {
      write: 1,
      move: :left,
      state: :e
    },
    1 => {
      write: 1,
      move: :right,
      state: :a
    }
  }
}

tape = [0]
state = :a
index = 0
n = 12172063
n.times do
  val = tape[index]
  act = blueprints[state][val]
  # Write
  tape[index] = act[:write]
  # Move
  case act[:move]
  when :right
    index += 1
    tape << 0 if index == tape.length
  when :left
    index -= 1
    if index < -1
      raise 'Invalid index'
    end
    if index < 0
      tape.unshift(0)
      index = 0
    end
  else
    raise 'Invalid move'
  end
  # State
  state = act[:state]
end
puts tape.count(1)
