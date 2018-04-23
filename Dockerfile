FROM angelcam/dapperbox

# Customize your assets or specs dir names
COPY assets/ $ASSETS_DIR
COPY specs/ $SPEC_DIR

COPY specs/swagger.yaml /dapperdox/static

# Convert swagger.yaml to swagger.json
COPY sripts/yaml_to_json.py /usr/local/bin
RUN yaml_to_json.py $SPEC_DIR/swagger.yaml $SPEC_DIR/swagger.json

# Custom configuration comes here
# ENV THEME my_own_theme

# Launch Dapperdox and open http://localhost:3123
CMD ["go-wrapper", "run"]
