FROM bircow/dapperdox:1.1.1

# Customize your assets or specs dir names
COPY assets/ $ASSETS_DIR
COPY specs/ $SPEC_DIR

# Convert swagger.yaml to swagger.json
RUN yaml_to_json.py $SPEC_DIR

# Custom configuration comes here
# ENV THEME my_own_theme

# Launch Dapperdox and open http://localhost:3123
CMD ["go-wrapper", "run"]