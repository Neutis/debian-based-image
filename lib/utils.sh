set_up_stages_skip()
{
    log "Begin set_up_stages_skip"
    find . -name "SKIP" | xargs rm -f
    if [ -n "$SKIP_STAGES" ]; then
        for STAGE_IDENTITIES in ${SKIP_STAGES}; do
            STAGE_POSTFIX=`echo ${STAGE_IDENTITIES} | awk -F: '{print $1}'`
            SUBSTAGE_PREFIX=`echo ${STAGE_IDENTITIES} | awk -F: '{print $2}'`
            stage_dir=${BASE_DIR}/stage${STAGE_POSTFIX}
            if [ -z "${SUBSTAGE_PREFIX}" -a -d $stage_dir ]; then
                log "Create SKIP file for directory $stage_dir"
                touch $stage_dir/SKIP
            fi
            if  [ -n "${SUBSTAGE_PREFIX}" ]; then
                for substage_dir in $stage_dir/${SUBSTAGE_PREFIX}*; do
                    log "Create SKIP file for directory $substage_dir"
                    touch $substage_dir/SKIP
                done
            fi
        done
    fi
    if [ -n "$RM_STAGE_EXPORTS_POSTFIXES" ]; then
        for STAGE_POSTFIX in ${RM_STAGE_EXPORTS_POSTFIXES}; do
            if [ -d ${BASE_DIR}/stage${STAGE_POSTFIX} ]; then
                if ls ${BASE_DIR}/stage${STAGE_POSTFIX}/EXPORT* 1>/dev/null 2>&1; then
                    log "Remove EXPORT files for stage${STAGE_POSTFIX}"
                    rm ${BASE_DIR}/stage${STAGE_POSTFIX}/EXPORT*
                fi
            fi
        done
    fi
    log "End set_up_stages_skip"
}
