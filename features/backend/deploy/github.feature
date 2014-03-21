Feature: Deploying via a GitHub deployment event

    Shipr accepts POST requests for the GitHub `deployment` event

    Scenario: A ping event
        When a ping event is received
        Then the last response should be 200 with the content:
            """
            {}
            """
    
    Scenario: A deployment event
        When a deployment event is received
        Then a job should have been created with:
            | sha         | ccfd249999a77dc63a81e8b591122b4655eb69d5 |
            | force       | false                                    |
            | environment | production                               |
            | config      | {}                                       |
        And a deploy task should have been created with env:
            | ENVIRONMENT | production                               |
            | FORCE       | 0                                        |
            | REPO        | git@github.com:remind101/shipr.git       |
            | SHA         | ccfd249999a77dc63a81e8b591122b4655eb69d5 |