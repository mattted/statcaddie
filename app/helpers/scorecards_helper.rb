module ScorecardsHelper
  def hole_par(f)
    "Par #{Hole.find_by(lid: "#{f.object.round.course_id}#{f.object.round.tee}#{f.object.hole_number}").par}"
  end
end
