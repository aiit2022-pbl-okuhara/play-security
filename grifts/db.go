package grifts

import (
	"fmt"

	"github.com/aiit2022-pbl-okuhara/play-security/models"

	. "github.com/gobuffalo/grift/grift"
	"github.com/gobuffalo/nulls"
	"github.com/gobuffalo/pop/v6"
	"github.com/gofrs/uuid"
)

// buffalo g task db:seed
// buffalo task db:seed
var _ = Namespace("db", func() {

	Desc("seed", "Seeds a database")
	Add("seed", func(c *Context) error {
		return models.DB.Transaction(func(tx *pop.Connection) error {
			if err := tx.TruncateAll(); err != nil {
				return err
			}

			// create company
			company := &models.Company{
				Name: "PlaySecurityTeam",
			}
			if _, err := company.Create(tx); err != nil {
				return err
			}

			// create organization
			organization := &models.Organization{
				CompanyID:        company.ID,
				Name:             "Sales",
				DisplayID:        1000,
				ReportSendEmails: "example@example.com",
			}
			if _, err := organization.Create(tx); err != nil {
				return err
			}

			// create story
			story := &models.Story{
				OrganizationID: organization.ID,
				Title:          "Story-1",
			}
			if _, err := story.Create(tx); err != nil {
				return err
			}

			// create tags
			// create story_taggings
			tags := models.Tags{
				{Name: "Tag-1"},
				{Name: "Tag-2"},
				{Name: "Tag-3"},
				{Name: "Tag-4"},
				{Name: "Tag-5"},
			}
			for _, tag := range tags {
				if _, err := tag.Create(tx); err != nil {
					return err
				}
				tagging := &models.StoryTagging{
					StoryID: story.ID,
					TagID:   tag.ID,
				}
				if _, err := tagging.Create(tx); err != nil {
					return err
				}
			}

			// create quizzes
			quiz := &models.Quiz{
				Question:       "Quiz master - Question1",
				FailureMessage: nulls.NewString("Quiz master - FailureMessage1"),
			}
			if _, err := quiz.Create(tx); err != nil {
				return err
			}

			// create quiz_options
			options := models.QuizOptions{
				{QuizID: quiz.ID, Answer: "Answer-1"},
				{QuizID: quiz.ID, Answer: "Answer-2"},
				{QuizID: quiz.ID, Answer: "Answer-3"},
				{QuizID: quiz.ID, Answer: "Answer-4"},
				{QuizID: quiz.ID, Answer: "Answer-5"},
			}
			var oids []uuid.UUID
			for _, option := range options {
				if _, err := option.Create(tx); err != nil {
					return err
				}
				oids = append(oids, option.ID)
			}

			// create roles
			// create scenarios
			roles := models.Roles{
				{OrganizationID: organization.ID, Name: "Role-1"},
				{OrganizationID: organization.ID, Name: "Role-2"},
				{OrganizationID: organization.ID, Name: "Role-3"},
			}
			for _, role := range roles {
				if _, err := role.Create(tx); err != nil {
					return err
				}
				scenario := &models.Scenario{
					StoryID:       story.ID,
					RoleID:        role.ID,
					Overview:      fmt.Sprintf("%s (%s) Overview.", story.Title, role.Name),
					Description:   fmt.Sprintf("%s (%s) Description.", story.Title, role.Name),
					HighestScore:  10,
					ResultMessage: fmt.Sprintf("%s (%s) ResultMessage.", story.Title, role.Name),
				}
				if _, err := scenario.Create(tx); err != nil {
					return err
				}

				// create scenario_quizzes
				q := &models.ScenarioQuiz{
					ScenarioID: scenario.ID,
					QuizID:     quiz.ID,
					First:      true,
				}
				if _, err := q.Create(tx); err != nil {
					return err
				}

				// create scenario_quiz_options
				for i, oid := range oids {
					var score, status int
					switch i {
					case 0:
						score = 0
						status = i
					default:
						score = 10
						status = 1
					}
					o := &models.ScenarioQuizOption{
						ScenarioQuizID: q.ID,
						QuizOptionID:   oid,
						Score:          score,
						Status:         status,
					}
					if _, err := o.Create(tx); err != nil {
						return err
					}
				}
			}

			return nil
		})
	})
})
