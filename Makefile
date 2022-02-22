.PHONY:	verify
verify:
	docker run --rm -v $(CURDIR)/services:/services redocly/openapi-cli lint \
		/services/v3/zkh-interrupt.yml \
		/services/v3/zkh-rooms.yml \
		/services/v3/zkh-timeline.yml \
		/services/v4/zkh-mylive.yml \
		/services/v4/zkh-review.yml \
		/services/v4/zkh-widget.yml \
		/services/workflow-simulation/openapi.yml \
		/services/upload/swagger.yml
