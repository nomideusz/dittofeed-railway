FROM temporalio/auto-setup:1.22.4

# Railway has no bind mounts — bake in the dynamicconfig file the upstream
# compose stack mounts from the dittofeed repo. prod.yaml is intentionally
# empty (upstream ships it empty); auto-setup only requires that it exists.
COPY dynamicconfig/prod.yaml /etc/temporal/config/dynamicconfig/prod.yaml

ENV DYNAMIC_CONFIG_FILE_PATH=config/dynamicconfig/prod.yaml
