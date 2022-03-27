# frozen_string_literal: true

json.array! @attends, partial: 'attends/attend', as: :attend
