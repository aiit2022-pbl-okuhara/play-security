package actions

import (
	"net/http"

	"github.com/gobuffalo/buffalo"
)

// ScenariosList default implementation.
func ScenariosList(c buffalo.Context) error {
	return c.Render(http.StatusOK, r.HTML("scenarios/index.html"))
}

// ScenariosShow default implementation.
func ScenariosShow(c buffalo.Context) error {
	return c.Render(http.StatusOK, r.HTML("scenarios/show.html"))
}

// ScenariosResult default implementation.
func ScenariosResult(c buffalo.Context) error {
	return c.Render(http.StatusOK, r.HTML("scenarios/result.html"))
}

// ScenariosQuizzesShow default implementation.
func ScenariosQuizzesShow(c buffalo.Context) error {
	return c.Render(http.StatusOK, r.HTML("scenarios/quizzes/show.html"))
}

// ScenariosQuizzesAnswer default implementation.
func ScenariosQuizzesAnswer(c buffalo.Context) error {
	return nil
}
