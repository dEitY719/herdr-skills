/**
 * herdr plugin for OpenCode.ai
 *
 * Auto-registers the skills directory via the config hook (no symlinks needed).
 */

import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

export const HerdrPlugin = async () => {
  const skillsDir = path.resolve(__dirname, '../../skills');

  return {
    // Config.get() returns a cached singleton, so a mutation here is visible
    // when skills are lazily discovered later.
    config: async (config) => {
      config.skills = config.skills || {};
      config.skills.paths = config.skills.paths || [];
      if (!config.skills.paths.includes(skillsDir)) {
        config.skills.paths.push(skillsDir);
      }
    },
  };
};
